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

  post {
      always {
          emailext body: 'A Test EMail', recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']], subject: 'Test'
      }
  }
}