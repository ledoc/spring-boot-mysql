FROM maven:3.5.3-jdk-8 AS build

COPY src/ src/
COPY pom.xml pom.xml


## affiche la liste des dépendances
# RUN mvn -B -f pom.xml -s /usr/share/maven/ref/settings-docker.xml dependency:resolve
RUN mvn -B -s /usr/share/maven/ref/settings-docker.xml package -DskipTests

FROM java:8-jdk-alpine
RUN adduser -Dh /home/treeptik treeptik

COPY --from=build target/spring-boot-mysql-0.0.1-SNAPSHOT.jar /home/treeptik/

ARG DB_USER_ARG="user-spring-boot-mysql"
ENV DB_USER=$DB_USER_ARG

ARG DB_PASS_ARG="pass-spring-boot-mysql"
ENV DB_PASS=$DB_PASS_ARG

ARG DB_URL_ARG="mysql_db:3306"
ENV DB_URL=$DB_URL_ARG

ARG DB_NAME_ARG="db-spring-boot-mysql"
ENV DB_NAME=$DB_NAME_ARG

## Download un utilitaire pour vraiment attendre que la BD soit ready
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.5.0/wait /wait
RUN chmod +x /wait


EXPOSE 8080
# ENTRYPOINT [ "java", "-jar", "/home/treeptik/spring-boot-mysql-0.0.1-SNAPSHOT.jar" ]
## Launch the wait tool and then your application
CMD /wait && java -jar /home/treeptik/spring-boot-mysql-0.0.1-SNAPSHOT.jar
