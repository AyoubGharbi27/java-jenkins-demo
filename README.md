# java-jenkins-demo
Minimal Java (Maven) project + Dockerfile + Jenkinsfiles (Linux & Windows) — ready to build and push.

## Quick start (local)
- Build: `mvn clean package`
- Run: `java -jar target/java-jenkins-demo-1.0-SNAPSHOT.jar`
- Build Docker image locally:
  ```
  docker build -t dingus27/java-jenkins-demo:local .
  docker run --rm dingus27/java-jenkins-demo:local
  ```

## Jenkins setup (Linux agent)
1. In Jenkins: Manage Jenkins → Global Tool Configuration  
   - Add JDK named `jdk-24` (point to your JDK 24 install)  
   - Add Maven named `maven3` (or change Jenkinsfile to your name)
2. Create a Pipeline job and point to this repo (or use Pipeline script).
3. Configure a Jenkins credential for Docker Hub (username/password or token) and set its ID to `dockerhub-credentials` (or update Jenkinsfile).
4. Run the job.

## Jenkins (Windows agent)
Use `Jenkinsfile.windows` — ensure agent has Docker Desktop running and Jenkins user can access it.

## Notes
- Replace Docker Hub repo (`dingus27/java-jenkins-demo`) in the Jenkinsfile with your own.
- The Jenkinsfiles perform: checkout, compile, test, package, docker build, docker push, cleanup.
