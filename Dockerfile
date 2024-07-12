# 빌드 스테이지
FROM maven:3.8.4-openjdk-11 as build 
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# 실행 스테이지
FROM openjdk:11.0.15.9-1
# target경로의 WAR파일 경로를 적어준다.(확인!)
COPY --from=build /app/target/spring_mvc.war /app.war 
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.war"]