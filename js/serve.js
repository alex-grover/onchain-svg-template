import EventEmitter from 'node:events'
import http from 'node:http'

export const IMAGE_REGEX = /\/image\/(\d+)/
export const ANIMATION_REGEX = /\/animation\/(\d+)/

export default async function serve(handler) {
  const events = new EventEmitter()

  function requestListener(req, res) {
    if (req.url === '/changes') {
      res.setHeader('Content-Type', 'text/event-stream')
      res.writeHead(200)
      const sendEvent = () => res.write('event: change\ndata:\n\n')
      events.on('change', sendEvent)
      req.on('close', () => events.off('change', sendEvent))
      return
    }

    if (req.url === '/') {
      res.writeHead(302, { Location: '/image/1' }).end()
      return
    } else if (req.url === '/collection' || IMAGE_REGEX.test(req.url)) {
      res.writeHead(200)
      handler(req.url).then(
        (content) => res.end(webpage(content)),
        (error) => res.end(webpage(`<pre>${error.message}</pre>`))
      )
      return
    } else if (ANIMATION_REGEX.test(req.url)) {
      res.writeHead(200)
      handler(req.url).then(
        (content) => res.end(content),
        (error) => res.end(webpage(`<pre>${error.message}</pre>`))
      )
      return
    }

    res.writeHead(404)
    res.end('Not found: ' + req.url)
  }
  const server = http.createServer(requestListener)
  await new Promise((resolve) => server.listen(9901, resolve))

  return () => events.emit('change')
}

const webpage = (content) => `
  <html lang="en">
    <head>
      <title>Onchain SVG Template</title>
      <style>
        body {
          margin: 0;
        }      
      </style>
    </head>
    <body>
      ${content}
    </body>
    <script>
      const sse = new EventSource('/changes')
      sse.addEventListener('change', () => window.location.reload())
    </script>
  </html>
`
