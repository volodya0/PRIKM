pipeline {
  agent any
  
  environment {
    DOCKER_IMAGE = 'volodauzuk02519/prikm'
  }
  
  stages {
    stage('Start') {
      steps {
        echo 'Start for monitoring and Jenkins'
      }
    }

    stage('Image build') {
      steps {
        sh "docker build -t prikm:latest ."
        sh "docker tag prikm $DOCKER_IMAGE:latest"
        sh "docker tag prikm $DOCKER_IMAGE:$BUILD_NUMBER"
      }
      // post{
      //   failure {
      //     script {
      //     // Send Telegram notification on success
      //       telegramSend message: "Job Name: ${env.JOB_NAME}\n Branch: ${env.GIT_BRANCH}\nBuild #${env.BUILD_NUMBER}: ${currentBuild.currentResult}\n Failure stage: '${env.STAGE_NAME}'"
      //     }
      //   }
      // }
      
    }

    stage('Push to registry') {
      steps {
        withDockerRegistry([ credentialsId: "dockerhub_token", url: "" ])
        {
          sh "docker push $DOCKER_IMAGE:latest"
          sh "docker push $DOCKER_IMAGE:$BUILD_NUMBER"
        }
      }
      // post{
      //   failure {
      //     script {
      //     // Send Telegram notification on success
      //       telegramSend message: "Job Name: ${env.JOB_NAME}\nBranch: ${env.GIT_BRANCH}\nBuild #${env.BUILD_NUMBER}: ${currentBuild.currentResult}\nFailure stage: '${env.STAGE_NAME}'"
      //     }
      //   }
      // }
    }

    stage('Deploy image'){
      steps{
        sh "docker stop \$(docker ps | grep '$DOCKER_IMAGE' | awk '{print \$1}') || true"
        sh "docker container prune --force"
        sh "docker image prune --force"
        //sh "docker rmi \$(docker images -q) || true"
        sh "docker run -d -p 8000:80 $DOCKER_IMAGE"
      }
      // post{
      //   failure {
      //     script {
      //     // Send Telegram notification on success
      //       telegramSend message: "Job Name: ${env.JOB_NAME}\nBranch: ${env.GIT_BRANCH}\nBuild #${env.BUILD_NUMBER}: ${currentBuild.currentResult}\nFailure stage: '${env.STAGE_NAME}'"
      //     }
      //   }
      // }
    }
  }

  // post {
  //   success {
  //     script {
  //       // Send Telegram notification on success
  //       telegramSend message: "Job Name: ${env.JOB_NAME}\n Branch: ${env.GIT_BRANCH}\nBuild #${env.BUILD_NUMBER}: ${currentBuild.currentResult}"
  //     }
  //   }
  // }
}