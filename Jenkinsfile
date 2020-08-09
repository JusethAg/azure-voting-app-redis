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
					# bash ./scripts/test_container.sh
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
					# pytest ./test_sample.py
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

		stage('Push container') {
			steps {
				echo "Workspace is $WORKSPACE"
				dir("$WORKSPACE/azure-vote") {
					script {
						docker.withRegistry('https://index.docker.io/v1', 'DockerHub') {
							def image = docker.build('jusethag/jenkins-test:latest')
							image.push()
						}
					}
				}
			}
		}

		stage('Container scanning') {
			parallel {
				stage('Run Anchore') {
					steps {
						anchore name: 'anchore_images'
					}
				}

				stage('Run Trivy') {
					steps {
						// sleep(time: 30, unit: 'SECONDS')
						sh(script: """
							trivy jusethag/jenkins-test
						""")
					}
				}
			}
		}
    }
}
