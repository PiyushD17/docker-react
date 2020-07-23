## builder phase
FROM node:alpine as builder 
WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .
## We do not need VOlume mounting in Production as we are not changing the code anymore

RUN npm run build
## all the stuff that we need is stored inside /app/build directory

## run phase, FROM starts a new phase
FROM nginx

## copy the build folder inside the new nginx container
COPY --from=builder /app/build /usr/share/nginx/html
