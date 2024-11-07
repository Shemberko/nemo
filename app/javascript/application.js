// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers"

import "./channels/comments_channel";
import { Turbo } from "@hotwired/turbo-rails";
Turbo.start();import "./channels"
