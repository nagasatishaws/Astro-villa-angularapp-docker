
pipeline {
   agent any
   environment {
       DOCKER_TAG = getDockerTag()
  }
  
   stages {
        stage("build docker image"){
           steps{
                  sh " docker build . -t nagasatish/kubee-docker-app:${DOCKER_TAG}"
       }
 }
        stage("Docker hub login"){
            steps{
             withCredentials([string(credentialsId: 'docker-password', variable: 'dockerhubPASS')]) {
            sh "docker login -u nagasatishdocker -p ${dockerhubPASS}"
            sh "docker push nagasatish/kubee-docker-app:${DOCKER_TAG}"

        }
  }
}

       stage("Deploy kubernetes"){
          steps{
                  sh "chmod +x changeTag.sh"
                  sh "./changeTag.sh ${DOCKER_TAG}"
                   
                   sshagent(['jenkins-docker-pem']) {
                      sh "scp -o StrictHostKeyChecking=no  node-service.yml node-deployment.yml ubuntu@172.31.24.206:/home/ubuntu/"
  
                      script {
                             try{
                                  sh "ssh ubuntu@72.31.24.206 kubectl apply -f ."
                         
                             }catch(error){

                                sh "ssh ubuntu@72.31.24.206 kubectl create -f ."

                             }
                         }
                     }
              }
        }
   }
}

 





     

  
