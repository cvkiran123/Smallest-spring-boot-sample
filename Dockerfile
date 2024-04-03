FROM registry.access.redhat.com/ubi8/openjdk-17:1.19-1 AS builder

#RUN mkdir /home/spring-petclinic
WORKDIR small-springboot-app
#USER root
COPY . .
#RUN chmod 755 /spring-petclinic
RUN ./mvnw clean package -Dcheckstyle.skip


FROM openjdk:11-jre-slim
COPY --from=builder small-springboot-app/target/*.jar /target/*.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","target/*.jar"]
