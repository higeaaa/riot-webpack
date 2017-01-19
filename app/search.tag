<search>
  <form onsubmit={ search }>
    <label>
      <input type="search"
             oninput={ search }
             onchange={ search }
             ref="s"
             placeholder="&#xf002; Search music tracks"
             id="search">
    </label>
  </form>

  <div if={ isLoading } class="loader">
    <div class="circle"> </div>
  </div>

  <p class="error" if={ error }>{ error }</p>


  <script>
    require('./results-cards.tag');

    var lastSearch = null;
    var searchUrl  = null;

    // Reset tag attributes to hide the errors and cleaning the results list
    let reset = () => {
      this.results = [];
      this.error   = false;
      searchUrl    = null;
    }

    // generate url for itunes API.
    let getApiUrl = searchWord => {
      let urlParams = {
        country: 'jp',
        lang: 'ja_jp',
        media: 'music',
        entity: 'song',
        app: 'music',
        limit: 15,
        term: searchWord
      };
      let url = 'https://itunes.apple.com/search';
      let keyValue, pat, key, value;

      for (key in urlParams) {
        key      = encodeURIComponent(key);
        value    = encodeURIComponent(urlParams[key]);
        keyValue = key + '=' + value;
        url += (url.length > 32 ? '&' : '?') + keyValue;
      };
      return url;
    }

    // Debounce the api requests
    let doApiRequest = debounce( searchUrl => {
      fetch(searchUrl, { method: 'get', mode: 'cors'})
        .then( res  => { return res.json() })
        .then( data => {
          reset();
          var r;
          if (this.refs.s.value) {
            if (data.resultCount) this.results = data.results;
            else this.error = data.Error;
          }
          this.isLoading = false;
          this.update();
          r = this.results;
          riot.mount('results-cards', { r });
        });
    }, 300, false);

    // Public API/method
    this.results = [];

    // Search callback
    search(e) {
      let searchWord = this.refs.s.value;
      if (!searchWord) {
        reset();
        setTimeout(function(){
          var r = [];
          riot.mount('results-cards', { r });
        }, 1000);
      } else if (lastSearch !== searchWord) {
        reset();
        this.isLoading = true;
        searchUrl = getApiUrl(searchWord)
        doApiRequest(searchUrl);
      };

      lastSearch = searchWord ;
    }

  </script>




  <style type="scss" scoped>
    :scope {
      position: absolute;
      top: 2rem;
      left: 50%;
      transform: translate(-50%, 0);
    }

    .error {
      color: #fffaaa;
      margin: 1rem 0;
    }

    label {
      display: flex;
      flex-direction: column;
      font-size: 1.6rem;
      span {
        text-shadow: 1px 1px 2px rgba(255, 255, 255, 0.8);
      }
    }

    #search {
      font-family: FontAwesome;
    }

    input {
      margin: 1rem 0 0;
      font-size: 1.6rem;
      font-weight: 300;
      padding: 0.8rem 1rem;
      color: dimgray;
      border: 1px solid rgba(255, 255, 255, 0.05);
      background: rgba(255, 255, 255, 0.5);
      transition: all 0.3s;
      box-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
      -moz-appearance: none;
      -webkit-appearance: none;
      outline: none;
      border-radius: 10px;
      &:focus {
        border: 1px solid transparent;
        background: rgba(255, 255, 255, 0.8);
      }
    }

    // loading circle
    .loader {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      margin: 6rem 0 0;
    }

    .circle {
      width: 44px;
      height: 44px;
      border-radius: 50%;
      border: solid 3px #fff;
      background: rgba(0, 0, 0, 0);
      animation-name: circle;
      animation-duration: 1s;
      animation-timing-function: ease-out;
      animation-iteration-count: infinite;
      animation-direction: normal;
    }

    @keyframes circle {
      from {
        transform: scale(0.2);
      }
      to {
        transform: scale(1);
        border-color: rgba(255, 255, 255, 0.1);
      }
    }
  </style>

</search>
