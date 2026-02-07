import { Elysia } from 'elysia';
import { hostname } from 'os';
import { networkInterfaces } from 'os';

export const whoami = new Elysia({ prefix: '/whoami' })
    .get('/', () => {
        return {
            message: "Hello from the cluster!",
            hostname: hostname(),
            ip: networkInterfaces()?.['eth0']?.[0]?.address,
            time: new Date().toISOString(),
        };
    });
