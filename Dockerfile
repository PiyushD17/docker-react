## builder phase
FROM node:alpine
# FROM node:alpine as builder 
WORKDIR '/app'

# COPY package.json .
COPY package.json ./
RUN npm install
# COPY . .
COPY . ./
## We do not need Volume mounting in Production as we are not changing the code anymore

RUN npm run build
## all the stuff that we need is stored inside /app/build directory

## run phase, FROM starts a new phase
FROM nginx

# Exposing port 80. Elastic Beanstalk will look at this DOckerfile and expose the port 80
# This instruction does not work on normal laptopns and machines
EXPOSE 80
## copy the build folder inside the new nginx container
COPY --from=0 /app/build /usr/share/nginx/html
# COPY --from=builder /app/build /usr/share/nginx/html
