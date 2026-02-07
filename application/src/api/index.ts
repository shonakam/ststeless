import { Elysia } from "elysia";
import { whoami } from "./modules/whoami";

const app = new Elysia()
  .get("/", () => "Hello Elysia")
  .group("/api", (app) =>
    app.use(whoami)
  )
  .listen(8080);

console.log(
  `🦊 Elysia is running at ${app.server?.hostname}:${app.server?.port}`,
);

export type App = typeof app;
