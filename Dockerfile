#production dockerfile
#section 1, install dependencies and execute npm run build
#output will be in the build folder 
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#section 2, run phase
FROM nginx
#want to copy something over from the other phase
# this nginx config is only for simple static apps
COPY --from=builder /app/build /usr/share/nginx/html