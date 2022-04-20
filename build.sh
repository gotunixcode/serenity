#!/bin/bash
#########################################################################################################################
## build.sh
## |- Description : Script to build/release serenity image
## |- Author      : Justin Ovens <jovens@gotunixcode.net>
#########################################################################################################################
##
## TODO:
##
##  - Need to update the script to accept the run number from github actions for automatic builds
##  - And also need to add logic so if a run id isn't supplied we use our internal build counter
##    and identify the image as a manual build.
##
##      What i'm thinking for builds coming from github actions  (date.run_num)
##      for manual builds date.m_build_number




echo "▶️ $0 $*"

# Variables
DATE=$(date '+%Y%m%d')


function display_help {
    echo "-------------------------------------------------------------------------------------------------------------------------"
    echo "${0} Paramater Help"
    echo "-------------------------------------------------------------------------------------------------------------------------"
    echo "The following paramaters do not require any additional arguments"
    echo " "
    echo "      -h          | Display this menu"
    echo "      -l          | Build image locally (do not push to any docker registry)"
    echo "      -p          | Do not purge old images before building (speed up building on dev systems"
    echo "      -d          | Enable dry-run mode"
    echo " "
    echo "The following paramaters require additional arguments"
    echo " "
    echo "      -t          | Override the Build Tag"
    echo "      -r          | Release the image to hub.docker.com"
    echo "      -c          | Specify build environmental file to use."
    echo "      -i          | Build counter (Using the GITHUB_RUN_NUMBER varible)"
    echo " "
    echo "-------------------------------------------------------------------------------------------------------------------------"
    exit 1
}

function load_build_file {
    BUILD_FILE=".build"
    if [[ -f "${BUILD_FILE}" ]]; then
        source ${BUILD_FILE}
    else
        BUILD_NUMBER=0
        echo "BUILD_NUMBER=${BUILD_NUMBER}" > ${BUILD_FILE}
    fi
}

function increment_build_number {
    BUILD_FILE=".build"
    if [[ -f "${BUILD_FILE}" ]]; then
        echo "▶️ Updating build number...."
        BUILD_NUMBER=$(($BUILD_NUMBER+1))
        if [[ -z "${DRY_RUN}" ]]; then
            echo "BUILD_NUMBER=${BUILD_NUMBER}" > ${BUILD_FILE}
        else
            echo "BUILD_NUMBER=${BUILD_NUMBER}"
        fi
    else
        load_build_file
    fi
}

function purge_images {
    if [[ "${PURGE_IMAGES}" != 0 ]]; then
        echo "▶️ Removing old container images...."
        echo y | ${DRY} docker system prune -a
    fi
}

function build_image {
    local -n arr=$2

    TAG_ARGS=""
    for tag in "${arr[@]}"; do
        TAG_ARGS="${TAG_ARGS} -t ${1}:${tag}"
    done

    ${DRY} docker build \
        -f Dockerfile \
        ${TAG_ARGS} .
    if [ $? -eq 0 ]; then
        echo "✅ Build Completed successfully"
    else
        echo "❌ Build Failure"
        exit 1
    fi
}

function push_image {
    if [[ "${DOCKERHUB_PUSH}" != 0 ]]; then
        local -n arr=$2

        for tag in "${arr[@]}"; do
            ${DRY} docker push ${1}:${tag}
        done
    fi
}


while getopts ":i:t:r:c:hlpd" opt; do
    case ${opt} in
        c)
            ENV_FILES+=("${OPTARG}")
            ;;
        d)
            DRY_RUN=1
            ;;
        h)
            display_help
            ;;
        i)
            BUILD_COUNT=${OPTARG}
            ;;
        l)
            DOCKERHUB_PUSH=0
            ;;
        p)
            PURGE_IMAGES=0
            ;;
        r)
            RELEASE=1
            RELEASE_VERSION=${OPTARG}
            ;;
        t)
            TAG_OVERRIDE=${OPTARG}
            ;;

    esac
done
shift $((OPTIND -1))

if [[ -n "${ENV_FILES}" ]]; then
    for env_file in "${ENV_FILES[@]}"; do
        if [[ -f "${env_file}" ]]; then
            echo "▶️ Loading environment file: ${env_file}"
            source ${env_file}
        else
            echo "❌ Environmental file does not exist: ${env_file}"
            exit 1
        fi
    done
else
    ENV_FILE="build.cfg"
    if [[ -f "${ENV_FILE}" ]]; then
        echo "▶️ Loading default environment file: ${ENV_FILE}"
        source ${ENV_FILE}
    else
        echo "❌ Environmental file does not exist: ${ENV_FILE}"
        exit
    fi
fi


if [[ -z "${NAME}" || -z "${DOCKERHUB_ADDR}" || -z "${DOCKERHUB_REPO}" || -z "${DOCKERHUB_ORG}" ]]; then
    echo "❌ Required environemntal variables missing"
    exit 1
fi

if [[ -z "${DRY_RUN}" ]]; then
    DRY=""
else
    echo "▶️ Dry run mode enabled"
    DRY="echo"
fi

if [[ "${RELEASE}" != 1 ]]; then
    BRANCH=$(git symbolic-ref --short HEAD)
fi

load_build_file
purge_images

BUILD_TAG=${DATE}.${BUILD_NUMBER}

if [[ "${RELEASE}" == 1 ]]; then
    echo "▶️ Building release [${RELEASE_VERSION}]"
    TAGS=("latest" "${RELEASE_VERSION}")
    build_image "${DOCKERHUB_ORG}/${NAME}" TAGS
    if [[ "${DOCKERUB_PUSH}" != 0 ]]; then
        ${DRY} docker login
        if [ $? -eq 0 ]; then
            echo "✅ Successfully logged into hub.docker.com"
        else
            echo "❌ Failure to login to hub.docker.com"
            exit 1
        fi

        push_image "${DOCKERHUB_ORG}/${NAME}" TAGS
    fi
else
    echo "▶️ Building [Branch: ${BRANCH}] [Tag: ${BUILD_TAG}]"
    TAGS=("${BRANCH}" "${BUILD_TAG}")
    build_image "${DOCKERHUB_ADDR}/${DOCKERHUB_REPO}/${NAME}" TAGS
    if [[ "${DOCKERUB_PUSH}" != 0 ]]; then
        push_image "${DOCKERHUB_ADDR}/${DOCKERHUB_REPO}/${NAME}" TAGS
    fi
fi

increment_build_number
purge_images
