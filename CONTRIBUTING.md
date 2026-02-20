# Contributing to OpenVAS Docker

Thank you for your interest in contributing to the OpenVAS Docker project! This document provides guidelines and instructions for contributing to this project.

## Table of Contents
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Requesting Features](#requesting-features)
  - [Submitting Pull Requests](#submitting-pull-requests)
- [Development Setup](#development-setup)
  - [Prerequisites](#prerequisites)
  - [Building the Project](#building-the-project)
  - [Testing](#testing)
- [Project Structure](#project-structure)
- [Coding Standards](#coding-standards)
- [Documentation](#documentation)
- [License](#license)

## Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment for everyone. We expect all contributors to:

- Use welcoming and inclusive language
- Be respectful of differing viewpoints and experiences
- Gracefully accept constructive criticism
- Focus on what is best for the community
- Show empathy towards other community members

Unacceptable behavior includes harassment, trolling, insulting/derogatory comments, and personal or political attacks.

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR-USERNAME/openvas-docker.git
   cd openvas-docker
   ```
3. **Add the upstream repository**:
   ```bash
   git remote add upstream https://github.com/sysplore/openvas-docker.git
   ```
4. **Create a branch** for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## How to Contribute

### Reporting Bugs

Before reporting a bug, please check the [existing issues](https://github.com/sysplore/openvas-docker/issues) to see if it has already been reported.

When creating a bug report, include as many details as possible:
- **Description**: Clear and concise description of the bug
- **Reproduction Steps**: Step-by-step instructions to reproduce the issue
- **Expected Behavior**: What you expected to happen
- **Actual Behavior**: What actually happened
- **Environment**:
  - OS and version
  - Docker version
  - Available memory
  - Architecture (amd64/arm64)
- **Logs**: Attach container logs (do not paste large logs directly)
- **Screenshots**: If applicable, add screenshots

### Requesting Features

Feature requests are welcome! When suggesting a feature:
- Explain the problem it would solve
- Describe the proposed solution
- Provide examples of similar implementations if applicable
- Consider whether the feature aligns with the project's scope

### Submitting Pull Requests

1. **Keep changes focused**: Each PR should address a single issue or feature
2. **Update documentation**: Update README.md, docs/, or other documentation as needed
3. **Add tests**: Include tests for new functionality when applicable
4. **Follow coding standards**: Adhere to the project's coding conventions
5. **Update version numbers**: If making significant changes, update version numbers appropriately

PR Submission Checklist:
- [ ] Code follows project conventions
- [ ] Documentation is updated
- [ ] Tests pass
- [ ] Commit messages are clear and descriptive
- [ ] PR description explains the changes and motivation

## Development Setup

### Prerequisites

- Docker Engine 20.10+ with Buildx enabled
- Git
- Bash shell
- Sufficient disk space (10GB+ recommended for builds)
- Multi-architecture build setup (for cross-platform builds)

### Building the Project

The project uses a multi-stage Docker build process with support for both `amd64` and `arm64` architectures.

#### Full Build (Recommended for Contributors)

```bash
# Run the main build script
./bin/base-rebuild.sh
```

This script will:
1. Build the base image (`ovasbase`)
2. Build the Greenbone Security Assistant (GSA) React application
3. Build the slim image (without database)
4. Build the full image (with pre-loaded database archives)
5. Push images to Docker Hub (if configured)

#### Manual Build

```bash
# Build the base image
cd ovasbase
docker buildx build --platform linux/amd64,linux/arm64 -t mitexleo/ovasbase:latest .

# Build the main image
cd ..
docker buildx build --platform linux/amd64,linux/arm64 --target slim -t mitexleo/openvas:latest-slim .
docker buildx build --platform linux/amd64,linux/arm64 --target final -t mitexleo/openvas:latest .
```

### Testing

The project includes comprehensive testing configurations:

#### Single Container Testing
```bash
cd testing/single-container
docker-compose up -d
# Access web interface at http://localhost:8080
```

#### Multi-Container Testing
```bash
cd testing/multi-container  
docker-compose up -d
# Access web interface at http://localhost:8080
```

#### Running Tests
- Verify container starts successfully
- Check web interface accessibility (HTTP 200)
- Validate PostgreSQL initialization
- Test feed synchronization
- Verify Redis connectivity

## Project Structure

```
openvas-docker/
├── bin/                    # Build and utility scripts
│   ├── base-rebuild.sh    # Main build script
│   └── daily.sh           # Automated update script
├── branding/              # Branding assets
├── build.d/              # Build scripts for components
├── compose/              # Docker Compose configurations
├── confs/                # Configuration files
├── docs/                 # Documentation
├── gsa-final/            # Built GSA web interface
├── ics-gsa/              # GSA source code
├── images/               # Image assets
├── multi-container/      # Multi-container configurations
├── ovasbase/             # Base Docker image
├── scripts/              # Container startup and management scripts
├── testing/              # Test configurations
└── tmp/                  # Temporary build files
```

## Coding Standards

### Shell Scripts
- Use `#!/usr/bin/env bash` shebang
- Enable error checking: `set -Eeuo pipefail`
- Use double brackets `[[ ]]` for conditionals
- Quote all variables: `"$variable"`
- Use `local` for function variables
- Include descriptive comments

### Dockerfiles
- Use multi-stage builds when possible
- Sort multi-line arguments alphabetically
- Use `LABEL` for metadata
- Include `HEALTHCHECK` directives
- Use `ARG` before `ENV` for build-time variables

### Commit Messages
Follow [Conventional Commits](https://www.conventionalcommits.org/):
```
feat: add new feature
fix: resolve issue with PostgreSQL initialization
docs: update README with build instructions
test: add single-container test
chore: update dependencies
```

## Documentation

- Update `README.md` for user-facing changes
- Update `docs/` directory for detailed documentation
- Include examples for new features
- Document environment variables and configuration options
- Keep version information up to date

## License

By contributing to this project, you agree that your contributions will be licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for details.

---

Thank you for contributing to making OpenVAS Docker better! 🐳🔒