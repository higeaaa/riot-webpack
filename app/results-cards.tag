<results-cards riot-tag='resultCards'>
  <div if={ opts.r.length } class="container">
    <a each={ opts.r } href="{ collectionViewUrl }" target="_blank">
      <div class="content">
        <img class="artwork" src={ artworkUrl100 } alt="">
        <div class="description">
          <label>{ trackName }</label>
          <span>{ collectionName } </span>
          <span>{ artistName }</span>
          <div class="logos">
            <img src="/public/img/Get_it_on_iTunes_Badge_JP_1214.svg" alt="">
            <img if={ isStreamable } src="/public/img/JP_Listen_on_Apple_Music_Badge.svg" alt="">
          </div>
        </div>
      </div>
    </a>
  </div>


  <style type="scss" scoped>
    :scope {
      position: absolute;
      top: 10rem;
      width: 100%;
    }

    results-cards {
      margin: .5rem;
    }

    .container {
      display: inline-flex;
      flex-wrap: wrap;
      justify-content: flex-start;
      align-items: stretch;
      align-content: stretch;
      a {
        text-decoration: none;
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
        background: linear-gradient(to bottom, #ffffff, #f1ecec);
        border: 1px solid rgba(201, 191, 191, 0.5);
        color: dimgray;
        font-size: 1.4rem;
        transition: 0.3s;
        margin: .5rem;
        flex-basis: 350px;
        &:hover {
          box-shadow: 2px 8px 16px 2px rgba(0, 0, 0, 0.2);
        }
      }
    }

   .artwork {
     margin: .5rem;
     max-height: 100px;
   }

   .content {
     display: inline-flex;
     justify-content: flex-start;
     align-items: stretch;
     width: 100%;
     height: 100%;
     .description {
       word-break: break-all;
       overflow-wrap: break-word;
       margin: .5rem;
       width: 100%;
       display: flex;
       flex-flow: column nowrap;
       justify-content: flex-start;
       span {
         font-size: .9rem;
         margin-top: 3px;
       }
       .logos {
         width: 100%;
         flex: 1;
         display: flex;
         justify-content: flex-end;
         img {
           height: 30px;
           align-self: flex-end;
         }
       }
     }
   }

  </style>
</results-cards>
