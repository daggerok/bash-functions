# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## AI & Spec‑Driven Development (SSD) Overview
- **Spec‑Driven Development (SSD)**: All changes are driven by a clear specification documented in this file before implementation.
- **AI Interaction**: Claude Code is the sole source of AI‑assisted guidance. Any AI‑generated suggestions, prompts, or tooling must be recorded here.
- **Claude Configuration**: Preferred model is `opus` with fast mode enabled for routine tasks; use `sonnet` for detailed analysis.
- **Verification**: Every code change must pass `./gradlew build` before merging.
- **Git Commits**: Do NOT include `Co-Authored-By` lines in commit messages.

## Key Development Commands
1. **Build**
   - `bash gradlew clean build` - Builds the project
   - `gradle clean build` - Alternative Gradle build

2. **Test**
   - `bash ./tests.sh` - Test runner script
   - `docker-compose exec app pytest` - Direct test execution

3. **Run Service**
   - `docker run -p 8080:8080 daggerok/example-app` - Standard Docker run
   - `docker-compose up -d` - Docker Compose deployment

4. **Health Checks**
   - `non_sudo_wait_for 8080` - Verify service readiness without sudo
   - `wait_healthy_docker_containers 3` - Check Docker container health

## Code Architecture
```
├── .build/          # Build artifacts
├── .usage/          # Usage examples
├── .cursor/         # Cursor-specific configurations
├── src/             # Main source directory
│   ├── main.bash    # Core Bash helpers
│   └── src/bash/    # Sudo/non-sudo helpers
└── docker-compose.yml # Service orchestration
```

## Critical Helper Functions
1. **Process Management**
   - `stop_any <ports>` - Kills processes running on specified ports
   - `non_sudo_stop_any <ports>` - Non-root version
   - `sudo_stop_any <ports>` - Root-required version

2. **Service Readiness**
   - `wait_for <ports>` - Waits for port readiness
   - `non_sudo_wait_for <ports>` - Non-privileged wait
   - `wait_healthy_docker_containers <count>` - Verifies Docker container health

## Security Considerations
- All production services run without sudo where possible
- Build artifacts stored in /tmp directory
- No secrets stored in codebase
- Docker images pulled from authenticated registry

## Development Best Practices
1. Never commit Docker credentials
2. Use Docker Compose for multi-container setups
3. Verify service readiness before deployment
4. Test with non-sudo workflows when possible

## Common Pitfalls
- Forgetting to run `gradle clean` before major changes
- Mixing sudo/non-sudo workflows in deployment scripts
- Ignoring health check failures
- Not waiting for Docker readiness before API calls
