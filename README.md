Hands-on DevOps practice — CI/CD, Docker, AWS, Terraform.
Started: June 2026

## What's built so far

### CI/CD Pipeline (week 1)
A full end-to-end pipeline triggered on every `git push`:

lint (flake8) → test (pytest) → docker build → push to GHCR → deploy to EC2

- **CI** — GitHub Actions runs lint, tests, builds and pushes Docker image to GHCR
- **CD** — SSHs into EC2, pulls latest image, restarts container on port 8080
- Pipeline completes in ~60 seconds

### Stack
- Python 3.11
- Docker + GHCR
- GitHub Actions
- AWS EC2 (t3.medium, Ubuntu 22.04)

## Repo structure

devops-journey/
├── .github/workflows/ci.yml   # full CI/CD pipeline
├── ci-cd/
│   └── 01-github-actions/
│       └── ci-lab/            # python app + tests + Dockerfile
├── daily-logs/                # what I learned each day
└── aws/                       # SAA notes and CLI cheatsheets

## Daily logs
- [June 4](daily-logs/2026-06-04.md) — full pipeline end to end
