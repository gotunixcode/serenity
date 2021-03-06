<h1 align="center">
  <a href="https://github.com/gotunixcode/serenity">
    <!-- Please provide path to your logo here -->
    <img src="docs/images/logo.png" alt="Logo">
  </a>
</h1>

<div align="center">
  Serenity
  <br />
<!--  <a href="#about"><strong>Explore the screenshots »</strong></a> -->
  <br />
  <br />
  <a href="https://github.com/gotunixcode/serenity/issues/new?assignees=&labels=bug&template=01_BUG_REPORT.md&title=bug%3A+">Report a Bug</a>
  ·
  <a href="https://github.com/gotunixcode/serenity/issues/new?assignees=&labels=enhancement&template=02_FEATURE_REQUEST.md&title=feat%3A+">Request a Feature</a>
  .<a href="https://github.com/gotunixcode/serenity/discussions">Ask a Question</a>
</div>

<div align="center">
<br />

[![Project license](https://img.shields.io/github/license/gotunixcode/serenity.svg?style=flat-square)](LICENSE)

[![Pull Requests welcome](https://img.shields.io/badge/PRs-welcome-ff69b4.svg?style=flat-square)](https://github.com/gotunixcode/serenity/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22)
[![code with love by gotunixcode](https://img.shields.io/badge/%3C%2F%3E%20with%20%E2%99%A5%20by-gotunixcode-ff1414.svg?style=flat-square)](https://github.com/gotunixcode)

</div>

<details open="open">
<summary>Table of Contents</summary>

- [About](#about)
  - [Built With](#built-with)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Roadmap](#roadmap)
- [Support](#support)
- [Project assistance](#project-assistance)
- [Contributing](#contributing)
- [Authors & contributors](#authors--contributors)
- [Security](#security)
- [License](#license)

</details>

---

## About

<table><tr><td>

> Project Serenity.  This is going to be hard to define at the moment i'm still trying to work out everything I want to include.
> To start i'm building a very very basic server inventory system but not as an inventory system, the inventory added along with
> location (sites), and tags, will be used to generate inventory files used by Ansible for automation. 
>
> With the help of Postgres, Redis, and Celery I will also be building a scheduler/reporting service to setup playbooks to run
> on schedules using a mixture of Celery and cron.
>
> As I get further along I'm also going to work on generating my inventory data using other inventory systems such as Netbox.
>
> I'm also going to be building in user management built around Ansible roles, I might even attempt to build an LDAPSync tool
> to scrape Active Directory OU's and groups, to dynamically add users to Linux systems using ansible/AD Groups.
> Part of this process will also depend on ssh key management which initially will just be standard ssh keys however,
> As the codebase matures i'm going to incorporate Keystore which was a standalone app that was essentially a
> self service SSH-CA signing service, but I will be combining it in Serenity.

<!--<details>
<summary>Screenshots</summary>
<br>

> **[?]**
> Please provide your screenshots here.

|                               Home Page                               |                               Login Page                               |
| :-------------------------------------------------------------------: | :--------------------------------------------------------------------: |
| <img src="docs/images/screenshot.png" title="Home Page" width="100%"> | <img src="docs/images/screenshot.png" title="Login Page" width="100%"> |

</details> -->

</td></tr></table>

### Built With

> We will be using a number of technologies to build Serenity. (The initial list)
> - Docker
> - Django/Python
> - Celery
> - Redis
> - Postgresql

## Getting Started

### Prerequisites

> A modern Linux system, you could run Serenity as a bare metal application if you desire, However it would be highly recommended
> building it using Docker (or Kubernetes)
>
> - Docker Project: https://github.com/gotunixcode/serenity-docker
> - I will eventually make a kubernetes deployment file and include it as well.

### Installation

> **[?]** TBD

## Usage

> **[?]** TBD

## Roadmap

> **[?]** TBD

<!-- See the [open issues](https://github.com/gotunixcode/serenity/issues) for a list of proposed features (and known issues).

- [Top Feature Requests](https://github.com/gotunixcode/serenity/issues?q=label%3Aenhancement+is%3Aopen+sort%3Areactions-%2B1-desc) (Add your votes using the 👍 reaction)
- [Top Bugs](https://github.com/gotunixcode/serenity/issues?q=is%3Aissue+is%3Aopen+label%3Abug+sort%3Areactions-%2B1-desc) (Add your votes using the 👍 reaction)
- [Newest Bugs](https://github.com/gotunixcode/serenity/issues?q=is%3Aopen+is%3Aissue+label%3Abug)
-->
## Support

> **[?]**
> Provide additional ways to contact the project maintainer/maintainers.

Reach out to the maintainer at one of the following places:

- [GitHub Discussions](https://github.com/gotunixcode/serenity/discussions)
- Contact options listed on [this GitHub profile](https://github.com/gotunixcode)

## Project assistance

If you want to say **thank you** or/and support active development of Serenity:

- Add a [GitHub Star](https://github.com/gotunixcode/serenity) to the project.
- Tweet about the Serenity.
- Write interesting articles about the project on [Dev.to](https://dev.to/), [Medium](https://medium.com/) or your personal blog.

Together, we can make Serenity **better**!

## Contributing

First off, thanks for taking the time to contribute! Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make will benefit everybody else and are **greatly appreciated**.


Please read [our contribution guidelines](docs/CONTRIBUTING.md), and thank you for being involved!

## Authors & contributors

The original setup of this repository is by [Justin Ovens](https://github.com/gotunixcode).

For a full list of all authors and contributors, see [the contributors page](https://github.com/gotunixcode/serenity/contributors).

## Security

Serenity follows good practices of security, but 100% security cannot be assured.
Serenity is provided **"as is"** without any **warranty**. Use at your own risk.

_For more information and to report security issues, please refer to our [security documentation](docs/SECURITY.md)._

## License

This project is licensed under the **GNU General Public License v3**.

See [LICENSE](LICENSE) for more information.

<!--
## Acknowledgements

> **[?]**
> If your work was funded by any organization or institution, acknowledge their support here.
> In addition, if your work relies on other software libraries, or was inspired by looking at other work, it is appropriate to acknowledge this intellectual debt too.
-->
