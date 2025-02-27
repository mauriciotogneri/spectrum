import {onRequest} from "firebase-functions/v2/https";

/*setGlobalOptions({
  memory: "1GiB",
  timeoutSeconds: 530,
})*/

export const healthcheck = onRequest((request, response) => {
  response.send("Hello from Firebase!");
});
