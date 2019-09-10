pipeline {
    agent {
        node {
            label 'slave2'
        }
    }
    tools {
        maven 'maven3'
    }
    stages {
        stage('checkout') {
            steps{
                git 'https://github.com/akhilesh9014/Maven-Java-Project.git'
            }
        }
        stage('build') {
            steps {
                sh 'mvn clean package'
            }
            post{
                always {
                    junit 'target/surefire-reports/*.xml'
                    archiveArtifacts artifacts: '**/*.war', onlySuccessful: true
                }
            }
        }
        stage('upload artifacts') {
            steps {
                sh 'mvn clean deploy'
            }

        }
        stage('deploy') {
            steps {
                deploy adapters: [tomcat8(path: '', url: 'http://192.168.33.13:8555/')], contextPath: 'hebbel', war: '**/*.war'
            }
        }
        stage('integration-test') {
            sh 'mvn clean verify'
        }
        stage('production') {
            steps {
                 timeout(time: 10, unit: 'SECONDS') {
			    input message: 'Do you want to continue?', submitter: 'Administrator'

            }
        }
        
    }

}
