import {
  GET,
  POST,
  isSuccess,
  isRedirect,
  isClientError,
  isServerError,
  statusText,
  buildUrl,
  normalizeMethod,
  isMethod,
} from "kordex:http";

console.log(GET);
console.log(POST);

console.log(isSuccess(200));
console.log(isRedirect(302));
console.log(isClientError(404));
console.log(isServerError(500));

console.log(statusText(200));
console.log(statusText(404));

console.log(buildUrl("https://example.com/", "/api/users"));
console.log(normalizeMethod("post"));
console.log(isMethod("PATCH"));
console.log(isMethod("CUSTOM"));
