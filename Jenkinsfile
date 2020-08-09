pipeline {
    agent any

    stages {
        stage('Verify branch') {
            steps {
                echo "$GIT_BRANCH"
            }
        }

        stage('Docker build') {
            steps {
                sh(script: 'sudo docker images -a')
                sh(script: """
                    cd azure-vote/
                    sudo docker build -t jenkins-pipeline .
                    sudo docker images -a
                    cd ..
                """)
            }
        }
    }
}
