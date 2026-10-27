# syntax=docker/dockerfile:1

# ---------- 构建阶段：容器内完成 Maven 打包，避免依赖本机环境 ----------
FROM maven:3.9-eclipse-temurin-21 AS builder

WORKDIR /build
# 先复制 pom，利用 Docker 层缓存减少依赖重复下载
COPY pom.xml ./
COPY src ./src

# 使用 BuildKit 缓存 Maven 本地仓库，重复构建时无需重新下载依赖
RUN --mount=type=cache,target=/root/.m2 \
    mvn -B -DskipTests clean package

# ---------- 运行阶段：仅保留 JRE 与可执行 jar ----------
FROM eclipse-temurin:21-jre-alpine

# Alpine 默认没有时区数据，项目按 HH:mm 生成 Redis Key，必须保证时区正确
RUN apk add --no-cache tzdata \
    && addgroup -S app \
    && adduser -S -G app app

WORKDIR /app
COPY --from=builder /build/target/*.jar app.jar

ENV TZ=Asia/Shanghai \
    JAVA_OPTS="-Xms256m -Xmx512m"

EXPOSE 9199
USER app

# 通过 sh -c 展开 JAVA_OPTS，便于在 compose 中调整堆大小
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
