if (!("remove" in Element.prototype)) {
  Element.prototype.remove = function () {
    if (this.parentNode) {
      this.parentNode.removeChild(this);
    }
  };
}

const headID = document.getElementsByTagName("head")[0];

function addFont(href, rel) {
  const font = document.createElement("link");
  font.href = href;
  font.rel = rel;
  headID.appendChild(font);
}

function addCSS(href, rel) {
  const css = document.createElement("link");
  css.href = href;
  css.rel = rel;
  headID.appendChild(css);
}

function addScript(src, type) {
  const script = document.createElement("script");
  script.src = src;
  script.type = type;
  headID.appendChild(script);
}

// Add link elements
addFont(
  "https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@400;700&display=swap",
  "stylesheet"
);
addFont(
  "https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@400;700&display=swap",
  "stylesheet"
);

addCSS("chatbot/chat.css", "stylesheet");
//addCSS('http://35.72.44.113/chat/assets/chat.css', 'stylesheet');

// const appCSS = document.createElement('link');
// appCSS.href = 'assets/css/chat_box.css';
// appCSS.rel = 'stylesheet';
// appCSS.type = 'text/css';
// appCSS.media = 'all';
// headID.appendChild(appCSS);

// Add script elements
// addScript('assets/plugins/jquery/jquery-3.2.1.min.js', 'text/javascript');
// addScript('assets/js/app.js', 'text/javascript');
// addScript('linkify.min.js', 'text/javascript');
// addScript('linkify-element.min.js', 'text/javascript');

// Add HTML script at bottom of webpage

// Source: https://labs.tadigital.com/index.php/2020/04/10/safe-ways-to-inject-html-through-javascript/
function createFragment(htmlStr) {
  const fragment = document.createDocumentFragment(),
    elem = document.createElement("div");
  elem.innerHTML = htmlStr;
  while (elem.firstChild) {
    fragment.appendChild(elem.firstChild);
  }
  return fragment;
}

// const target = document.querySelector('body');
// target.appendChild(createFragment(
document.write(
  '<iframe class="webchat-ctn webchat-hide" scrolling="no" frameborder="0" marginwidth="0" marginheight="0" class="wc-webchat" src="http://35.72.44.113/chat/"></iframe>'
);
// document.write(
//   '<iframe class="webchat-ctn webchat-hide" scrolling="no" frameborder="0" marginwidth="0" marginheight="0" class="wc-webchat" src="chatbot/iframe.html"></iframe>'
// );
// ));

/* viewport保管 */
const mediaQuery = window.matchMedia("(max-width: 767px)");
let chatbotVp;
window.addEventListener("message", function (e) {
  let response = e.data;
  if (response === "chacbotShow") {
    document.querySelector(".webchat-ctn").classList.remove("webchat-hide");
    document.querySelector("body").classList.add("webchat-body");
    chatbotVp = document.querySelector('meta[name="viewport"]')
      ? document.querySelector('meta[name="viewport"]').content
      : "";
    if (mediaQuery.matches) {
      if (chatbotVp != "") {
        document
          .querySelector('meta[name="viewport"]')
          .setAttribute("content", "width=device-width, initial-scale=1.0");
      } else {
        let meta = document.createElement("meta");
        meta.name = "viewport";
        meta.content = "width=device-width, initial-scale=1.0";
        headID.appendChild(meta);
      }
    }
  }
  if (response === "chacbotHide") {
    if (mediaQuery.matches) {
      if (chatbotVp != "") {
        document
          .querySelector('meta[name="viewport"]')
          .setAttribute("content", chatbotVp);
      } else {
        document.querySelector('meta[name="viewport"]').remove();
      }
    }
    document.querySelector(".webchat-ctn").classList.add("webchat-hide");
    document.querySelector("body").classList.remove("webchat-body");
  }
  if (response === "chatbotClose") {
    document.querySelector(".webchat-ctn").remove();
  }
});
