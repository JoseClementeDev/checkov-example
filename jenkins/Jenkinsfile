pipeline {
    agent {
        docker {
            image 'kennethreitz/pipenv:latest'
            args '-u root --privileged -v /var/run/docker.sock:/var/run/docker.sock'
            label 'agent'
        }
    }
    stages {
        stage('test') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'github', url: 'git@github.com:bridgecrewio/checkov.git']]])
                script {
                    sh "pipenv install"
                    sh "pipenv run pip install checkov"
                    sh "pipenv run checkov --directory ./Cloudformation -o junitxml > result.xml || true"
                    junit "result.xml"
                }
            }
        }
    }
    options {
        preserveStashes()
        timestamps()
        ansiColor('xterm')
    }
}