pipeline {
    environment {
        BUILD_NUM = ''
    }
    agent any
    tools {
        maven 'maven'
        jdk 'jdk'
    }
    stages {
        // stage('SonarQube analysis') {
        //     steps {
        //         withSonarQubeEnv('sonar') {
        //             sh "mvn clean package sonar:sonar"
        //         }
        //     }
        // }
        // stage("Quality gate") {
        //     steps {
        //         waitForQualityGate abortPipeline: true
        //     }
        // }
        stage('Build') {
            steps {
                //sh 'mvn clean install -Dv=${BUILD_NUMBER} -Dartifactory.publish.artifacts=true -Dartifactory.publish.buildInfo=true'
                sh 'mvn clean package'
                //sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        // stage('Deliver') {
        //     steps {
        //         script {
        //         sh "chmod a+x jenkins/scripts/deploy.sh"
        //         sh "echo 'chmod successful' "
        //         sh "./jenkins/scripts/deploy.sh"
        //     }
        // }
        // }
        stage('Test Path') {
            steps {
                sh 'pwd'
                sh 'ls target/'
            }
        }
        stage ('Publish Artifacts') {
        steps {
            rtUpload (
                buildName: JOB_NAME,
                buildNumber: BUILD_NUMBER,
                serverId: "artifactory", // Obtain an Artifactory server instance, defined in Jenkins --> Manage:
                spec: """{
                            "files": [
                                {
                                    "pattern": "target/my-app-1.0-SNAPSHOT.jar",
                                    "target": "maven_local/my-app-1.0-SNAPSHOT.${BUILD_NUMBER}.jar",
                                    "recursive": "true"
                                }
                            ]
                    }"""   
                )
        }
     } 
    
    //  stage ('pull artifact') {
    //     steps{
    //         rtDownload (
    //         serverId: "jenkins-artifactory",
    //         spec: """{
    //             "files": [
    //                 {
    //                 "pattern": "maven_local/my-app-1.0-SNAPSHOT.jar",
    //                 "target": "app/"
    //                 }
    //             ]
    //         }"""
    //     )
    //     }
    // }
    // stage ('copy file to remote server') {
    //         steps {
    //             sh 'sudo scp -v -o StrictHostKeyChecking=no -i /home/ubuntu/nouman_pk.pem /var/lib/jenkins/workspace/test-job/app/my-app-1.0-SNAPSHOT.jar ubuntu@3.235.178.92:/home/ubuntu'
    //             sh 'sudo scp -v -o StrictHostKeyChecking=no  -i /home/ubuntu/nouman_pk.pem jenkins/scripts/deliver.sh ubuntu@3.235.178.92:/home/ubuntu'
    //             sh 'sudo ssh -i /home/ubuntu/nouman_pk.pem ubuntu@3.235.178.92 sudo chmod a+x deliver.sh'
    //             sh 'sudo ssh -i /home/ubuntu/nouman_pk.pem ubuntu@3.235.178.92 sudo  ./deliver.sh'
    //         }
    //     }
    //  stage('transfer artifacts') {
    //                 steps {
    //                       sshPublisher(
    //                       publishers:
    //                       [sshPublisherDesc
    //                       (configName: 'ubuntu',
    //                        transfers: [sshTransfer(
    //                        excludes: '',
    //                        execCommand: 'cd /tmp/tmp/jenkins/scripts;sudo chmod a+x deliver.sh;sudo ./deliver.sh ',
    //                        execTimeout: 350000,
    //                        flatten: false,
    //                        makeEmptyDirs: true,
    //                        noDefaultExcludes: false,
    //                        patternSeparator: '[, ]+',
    //                        remoteDirectory: '/tmp',
    //                        remoteDirectorySDF: false,
    //                        removePrefix: '', sourceFiles: '**/*')],
    //                        usePromotionTimestamp: false,
    //                        useWorkspaceInPromotion: false,
    //                        verbose: true)])
    //                       }
    //           }
    // //  stage ('slack notification') {
    // //      steps {
    // //          slackSend "Build waiting for approval - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)"
    // //      }
    // //  }
    // //  stage('Approval') {
    // //         steps {
    // //             script {
    // //                 slackSend channel: '#slack-alerts', 
    // //                 message: "${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)"
    // //                 mail (to: 'n72884@gmail.com',
    // //                 subject: "Job '${env.JOB_BASE_NAME}' (${env.BUILD_NUMBER}) is waiting for input",
    // //                 body: "Please go to console output of ${env.BUILD_URL} to approve or Reject.");
    // //                 def deploymentDelay = input id: 'Deploy', message: 'Deploy to production?', submitter: 'nouman'
    // //             }
    // //         }
    // //     }
    // // stage ('Deploy To QA'){
    // //     input
    // //         {
    // //             message "Do you want to proceed for production deployment?"
    // //         } 
    // //         steps {
    // //                     sh 'echo "Deploy into Prod"'

    // //                 }
    // //             }
    // // stage ('Trigger other pipeline') {
    // //     steps {
    // //         build job: 'java-hello-world-approved'
    // //         }
    // // }
  }
}
  