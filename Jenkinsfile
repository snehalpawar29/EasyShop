
@Library('shared') _

pipeline {
    agent any
    environment{
        DOCKER_IMAGE_NAME = 'snehalpawar2945/easyshop'
        DOCKER_IMAGE_TAG = "${BUILD_NUMBER}"
        DOCKER_MIGRATION_IMAGE_NAME = 'snehalpawar2945/easyshop-migration'
        GIT_BRANCH = "main"
        GITHUB_URL = "https://github.com/snehalpawar29/EasyShop.git"
    }
    stages {
        stage('Cleanup Workspace'){
            steps {
                script {
                    clean_ws()
                }
            }
        }
         stage ('Cloning'){
             steps{
                 script {
                     clone(
                         branch: env.GIT_BRANCH,
                         url: env.GITHUB_URL
                         )
                 }
             }
         }
         stage ('Build Docker Images'){
              parallel {
               stage('EasyShop Image Building') {
                  steps{
                      script{
                         dir('EasyShop')
                         {
                             docker_build (
                                  imageName: env.DOCKER_IMAGE_NAME,
                                 imageTag: env.DOCKER_IMAGE_TAG,
                                  dockerfile: 'Dockerfile',
                                  context: '.'
                          )
                     }
                 }
             }
       }
              stage('Migration Image Building'){
                     steps{
                         script{
                             dir('EasyShop')
                             {
                                 docker_build(
                                  imageName: env.DOCKER_MIGRATION_IMAGE_NAME,
                                 imageTag: env.DOCKER_IMAGE_TAG,
                               dockerfile: 'scripts/Dockerfile.migration',
                                  context: '.'
                              )
                             }
                         }
                      }
                  }
      }
  }
       stage ('Run Test'){
           steps{
                 echo "Run Test"
             }
          }
          stage('Security Scan using trivy'){
             steps{
                 script{
                      trivy_scan()
               }
              }
          }
          stage ('Push Docker Images'){
           parallel { 
              stage('Pushing App Image')  {
                  steps{
                      script{
                      docker_push(
                          imageName: env.DOCKER_IMAGE_NAME,
                              imageTag: env.DOCKER_IMAGE_TAG,
                              credentials: 'docker-hub-credentials'
                          )
                  }
              }}
              stage('Pushing Migration Image')  {
                  steps{
                      script{
                          docker_push( 
                              imageName: env.DOCKER_MIGRATION_IMAGE_NAME,
                              imageTag: env.DOCKER_IMAGE_TAG,
                              credentials: 'docker-hub-credentials'
                          )
                  }
              }}
           }
          }
stage ('Update Kubernetes Manifests'){
    steps {
        update_k8s_manifests(
            imageTag: env.DOCKER_IMAGE_TAG,
            manifestsPath: 'kubernetes',
            gitCredentials: 'github-credentials',
            gitUserName: 'snehalpawar29',
            gitUserEmail: 'snehalpawar2945@gmail.com'
        )
    }
}


    }
        post {
        always {
            clean_ws() 
        }
    }
}
