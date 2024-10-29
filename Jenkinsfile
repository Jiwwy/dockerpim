#!/usr/bin/env groovy
pipeline {
	environment {
        IMAGEN = "asinfo/pim1"
		NAME_CONTAINER = "PIM1"
		PORT_NUMBER = "8022"
		USUARIO_DH = credentials('docker-login-creds') //Se creo credencias en configuracion de jenking 
    }
    agent any
    // Clone mi repositorio git para descargar Dockerfile para generar imagen (Imagen de debian con java y wildfly)
    stages {		
		stage('Clone') {
            steps {
                git branch: "main", url: 'https://github.com/Jiwwy/dockerpim.git'
            }
        }
 
		stage('Build Imagen'){
			steps {
				script {
					newApp = docker.build "$IMAGEN:$BUILD_NUMBER"
				}	
			}
		}
		// Test funcionamiento de imagen construccion de contenedor test comando java 
		stage("Test Run Imagen") {
            steps {
                script {
                    docker.image("$IMAGEN:$BUILD_NUMBER").withRun('-p $PORT_NUMBER:8020 --name $NAME_CONTAINER -t'){
					sh label: 
					'Running test',
					script: '''
					java -version
					'''
					}
				}
			}				
        }
		// Subir imagen a docker hub
		stage('Deploy') {
            steps {
                script {
                    docker.withRegistry( '', 'docker-login-creds') {
                        newApp.push("$BUILD_NUMBER")
                    }
                }
            }
        }
		
		 stage('Clean Up') {
            steps {
                sh "docker rmi $IMAGEN:$BUILD_NUMBER"
                }
        }
	}
}
