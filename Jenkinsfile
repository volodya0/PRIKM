pipeline {
  agent any

  stages {
    stage('Start') {
      steps {
        echo 'Lab_2: started by GitHub'
      }
    }

    stage('Image build') {
      steps {
        sh "docker build -t prikm:latest ."
        sh "docker tag prikm volodauzuk02519/prikm:latest"
        sh "docker tag prikm volodauzuk02519/prikm:$BUILD_NUMBER"
      }
    }

    stage('Push to registry') {
      steps {
        withDockerRegistry([ credentialsId: "dockerhub_token", url: "" ])
        {
          sh "docker push volodauzuk02519/prikm:latest"
          sh "docker push volodauzuk02519/prikm:$BUILD_NUMBER"
        }
      }
    }

    stage('Deploy image'){
      steps{
        sh "docker stop \$(docker ps -q) || true"
        sh "docker container prune --force"
        sh "docker image prune --force"
        //sh "docker rmi \$(docker images -q) || true"
        sh "docker run -d -p 80:80 volodauzuk02519/prikm"
      }
    }
  }  
post{
success{
script{
// Send Telegram notification on success
telegramSend message: "Job Name: ${env.JOB_NAME}\n Branch: ${env.GIT_BRANCH}\nBuild #${env.BUILD_NUMBER}: ${currentBuild.currentResult}"
}
}
}

}