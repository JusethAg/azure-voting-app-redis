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
                sh(script: 'docker images -a')
                sh(script: """
                    cd azure-vote/
                    docker build -t jenkins-pipeline .
                    docker images -a
                    cd ..
                """)
            }
        }

        stage('Start test app') {
            steps {
				sh(script: """
					# docker-compose up -d
					bash ./scripts/test_container.sh
				""")
			}
			post {
				success {
					echo "App started successfully"
				}
				failure {
					echo "App failed to start"
				}
			}
        }

		stage('Run tets') {
			steps {
				sh(script: """
					pytest ./test_sample.py
				""")
			}
		}

		stage('Stop test app') {
			steps {
				sh(script: """
					# docker-compose down
				""")
			}
			
		}
    }
}
