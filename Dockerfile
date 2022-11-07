FROM cirrusci/flutter:stable

WORKDIR /app

COPY ./ ./

VOLUME ./build/ 

RUN flutter pub get
RUN flutter build apk --release
RUN flutter build web --release