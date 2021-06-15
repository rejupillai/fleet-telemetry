"/opt/local/apache-maven-3.6.3/bin/mvn" install -f "/Users/reju/code/delhi-launch/fleet-telemetry/position-simulator/pom.xml"
"/opt/local/apache-maven-3.6.3/bin/mvn" install -f "/Users/reju/code/delhi-launch/fleet-telemetry/photo-service/pom.xml"
"/opt/local/apache-maven-3.6.3/bin/mvn" install -f "/Users/reju/code/delhi-launch/fleet-telemetry/position-tracker/pom.xml"
"/opt/local/apache-maven-3.6.3/bin/mvn" install -f "/Users/reju/code/delhi-launch/fleet-telemetry/staff-service/pom.xml"
"/opt/local/apache-maven-3.6.3/bin/mvn" install -f "/Users/reju/code/delhi-launch/fleet-telemetry/api-gateway/pom.xml"
"/opt/local/apache-maven-3.6.3/bin/mvn" install -f "/Users/reju/code/delhi-launch/fleet-telemetry/vehicle-telemetry/pom.xml"
cd /Users/reju/code/delhi-launch/fleet-telemetry/webapp-angular
npm install
ng build --prod

cd ..

docker build -t reju/position-simulator:d1 -f position-simulator/Dockerfile position-simulator
docker build -t reju/api-gateway:d1 -f api-gateway/Dockerfile api-gateway
docker build -t reju/photo-service:d1 -f photo-service/Dockerfile photo-service
docker build -t reju/position-tracker:d1 -f position-tracker/Dockerfile position-tracker
docker build -t reju/vehicle-telemetry:d1 -f vehicle-telemetry/Dockerfile vehicle-telemetry
docker build -t reju/staff-service:d1 -f staff-service/Dockerfile staff-service
docker build -t reju/webapp-angular:d1 -f webapp-angular/Dockerfile webapp-angular 



docker push reju/position-simulator:d1
docker push reju/photo-service:d1
docker push reju/api-gateway:d1
docker push reju/photo-service:d1
docker push reju/position-tracker:d1
docker push reju/vehicle-telemetry:d1
docker push reju/staff-service:d1
docker push reju/webapp-angular:d1