def mvnHOME
pipeline {
    agent {
        label "slave2"
    }
    tool {
        maven 'maven3'
    }
    stages {
        stage('clone github') {
            steps {
                     echo " git cloning is processing"
                git 'https://github.com/akhilesh9014/Maven-Java-Project.git'
                stash 'scm'
                script{
                    mvnHOME = tool 'maven3'
                }
                     echo " git cloning is completed"
            }
        }
        stage('static-analysis') {
            steps {
                sh "'${mvnHOME}/bin/mvn' clean cobertura:cobertura"
            }
            post {
                success {
                    cobertura autoUpdateHealth: false, autoUpdateStability: false, coberturaReportFile: 'target/site/cobertura/coverage.xml', conditionalCoverageTargets: '70, 0, 0', failUnhealthy: false, failUnstable: false, lineCoverageTargets: '80, 0, 0', maxNumberOfBuilds: 0, methodCoverageTargets: '80, 0, 0', onlyStable: false, sourceEncoding: 'ASCII', zoomCoverageChart: false 
                }
            }
        }
        stage('build') {
            steps {
                sh "'{$mvnHOME}/bin/mvn' clean package"
            }
            post {
                always{
                    junit 'target/surefire-reports/*.xml'
                    archiveArtifacts '**/*.war'
                }
            }
        }
        stage('copy artifact ') {
            steps { 
                sh "'{mvNHOME}/bin/mvn' clean deploy"
            }
        }
        stage('deploy to tomcat') {
            steps {
                deploy adapters: [tomcat8(path: '', url: 'http://192.168.33.13:8555')], contextPath: 'webapp', war: '**/*.war'
            }
        }
        stage('integration-testing') {
            sh "'{mvnHOME}/bin/mvn' clean verify"
        }
        stage('creat docs') {
            steps {
                sh "'{mvnHOME}/bin/mvn' clean site"
            }
        }
        stage('deploy to production') {
            steps {
                imeout(time: 2, unit: 'HOURS') {
                    input message: 'Deploy to Production?', submitter: 'Admin'

                }
            }
        }
    }
}
