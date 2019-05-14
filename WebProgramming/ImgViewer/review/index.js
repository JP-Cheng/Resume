var imgArr = [
  {
    url: 'https://images-na.ssl-images-amazon.com/images/I/81-f2EhY7cL.jpg',
    name: 'x',
    singer: 'Ed Sheeran'
  },
  {
    url: 'https://iscale.iheart.com/catalog/album/55145087',
    name: 'Geography',
    singer: 'Tom Misch'
  },
  {
    url:
      'http://press.atlanticrecords.com/wp-content/uploads/2015/11/AHFOD-Digital-Album-Cover.jpg',
    name: 'A Head Full Of Dreams',
    singer: 'Coldplay'
  },
  {
    url:
      'https://is5-ssl.mzstatic.com/image/thumb/Features/v4/61/11/66/61116679-c20b-236c-d5bb-1e4747f55f5c/V4HttpAssetRepositoryClient-ticket.iorjwlhy.jpg-5401381937623795191.jpg/1200x630bb.jpg',
    name: '+',
    singer: 'Ed Sheeran'
  },
  {
    url: 'https://i.kfs.io/album/global/35676474,0v1/fit/500x500.jpg',
    name: '時間的產物',
    singer: 'DSPS'
  },
  {
    url:
      'https://cfstatic.streetvoice.com/profile_images/ac/cu/accusefive/iBbYrJb2tn4kovSi5uffjJ.png?x-oss-process=image/resize,m_fill,h_600,w_600,limit_0/interlace,1/quality,q_85/format,jpg',
    name: '披星戴月的想你',
    singer: '告五人'
  },
  {
    url:
      'https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/002/020/20/0020202088.jpg&v=5a13e6d9&w=348&h=348',
    singer: '甜約翰',
    name: 'Dare'
  },
  { url: 'http://music.fetnet.net/img/album/1535418.jpg', singer: '落日飛車', name: 'JINJI KIKKO' },
  {
    url:
      'https://assets.fontsinuse.com/static/use-media-items/29/28916/full-2837x2820/56701abc/maxresdefault.jpeg?resolution=0',
    singer: 'Coldplay',
    name: 'Parachutes'
  }
];

// DOM Objects
let nextBtn = document.getElementById('next');
let backBtn = document.getElementById('back');
let display = document.getElementById('display');
let displayNext = document.getElementById('display-next');
let displayPrev = document.getElementById('display-prev');
let source = document.getElementById('source');
let repeat = document.getElementById('checkbox-repeat');
let shuffle = document.getElementById('checkbox-shuffle');

function compare(a, b) {
  if (a.name < b.name) return -1;
  if (a.name > b.name) return 1;
  return 0;
}

imgArr = imgArr.sort(compare);
let imgNumber = 1;
let imgLength = imgArr.length;

//initial image
loadImage(display, imgArr[imgNumber].url);
loadImage(displayNext, imgArr[imgNumber + 1].url);
loadImage(displayPrev, imgArr[imgNumber - 1].url);
source.innerHTML = imgArr[imgNumber].name + '<br/>' + imgArr[imgNumber].singer;

nextBtn.onclick = changeNext;
backBtn.onclick = changeBack;

function loadImage(display, source) {
  display.src = '';
  let downloadingImage = new Image();
  downloadingImage.onload = function() {
    display.src = this.src;
  };
  downloadingImage.src = source;
}

function disableBtn(btn) {
  btn.disabled = true;
  btn.classList.add('disabled');
}

function enableBtn(btn) {
  btn.disabled = false;
  btn.classList.remove('disabled');
}

function changeNext(e) {
  e.preventDefault();

  if (!repeat.checked) {
    loadImage(display, imgArr[++imgNumber].url);
    loadImage(displayPrev, imgArr[imgNumber - 1].url);
    source.innerHTML = imgArr[imgNumber].name + '<br/>' + imgArr[imgNumber].singer;
    if (imgNumber >= imgLength - 1) {
      disableBtn(nextBtn);
      displayNext.style.opacity = 0;
    } else {
      loadImage(displayNext, imgArr[imgNumber + 1].url);
    }

    if (imgNumber > 0) {
      enableBtn(backBtn);
      displayPrev.style.opacity = 100;
    }
  } else {
    if (imgNumber === imgLength - 2) {
      loadImage(display, imgArr[++imgNumber].url);
      loadImage(displayPrev, imgArr[imgNumber - 1].url);
      loadImage(displayNext, imgArr[0].url);
    } else if (imgNumber >= imgLength - 1) {
      imgNumber = 0;
      loadImage(display, imgArr[imgNumber].url);
      loadImage(displayPrev, imgArr[imgLength - 1].url);
      loadImage(displayNext, imgArr[imgNumber + 1].url);
    } else {
      loadImage(display, imgArr[++imgNumber].url);
      loadImage(displayPrev, imgArr[imgNumber - 1].url);
      loadImage(displayNext, imgArr[imgNumber + 1].url);
    }
    source.innerHTML = imgArr[imgNumber].name + '<br/>' + imgArr[imgNumber].singer;
  }
}

function changeBack(e) {
  e.preventDefault();

  if (!repeat.checked) {
    loadImage(display, imgArr[--imgNumber].url);
    loadImage(displayNext, imgArr[imgNumber + 1].url);
    source.innerHTML = imgArr[imgNumber].name + '<br/>' + imgArr[imgNumber].singer;

    if (imgNumber <= 0) {
      disableBtn(backBtn);
      displayPrev.style.opacity = 0;
    } else {
      loadImage(displayPrev, imgArr[imgNumber - 1].url);
    }

    if (imgNumber < imgLength - 1) {
      enableBtn(nextBtn);
      displayNext.style.opacity = 100;
    }
  } else {
    if (imgNumber === 1) {
      loadImage(display, imgArr[--imgNumber].url);
      loadImage(displayPrev, imgArr[imgLength - 1].url);
      loadImage(displayNext, imgArr[imgNumber + 1].url);
    } else if (imgNumber <= 0) {
      imgNumber = imgLength - 1;
      loadImage(display, imgArr[imgNumber].url);
      loadImage(displayPrev, imgArr[imgNumber - 1].url);
      loadImage(displayNext, imgArr[0].url);
    } else {
      loadImage(display, imgArr[--imgNumber].url);
      loadImage(displayPrev, imgArr[imgNumber - 1].url);
      loadImage(displayNext, imgArr[imgNumber + 1].url);
    }
    source.innerHTML = imgArr[imgNumber].name + '<br/>' + imgArr[imgNumber].singer;
  }
}

function shuffleFunc(a) {
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

shuffle.onclick = shuffleChange;
function shuffleChange() {
  if (shuffle.checked) {
    imgArr = shuffleFunc(imgArr);
    loadImage(display, imgArr[imgNumber].url);
    loadImage(displayPrev, imgArr[imgNumber - 1].url);
    loadImage(displayNext, imgArr[imgNumber + 1].url);
  } else {
    imgArr = imgArr.sort(compare);
    loadImage(display, imgArr[imgNumber].url);
    loadImage(displayPrev, imgArr[imgNumber - 1].url);
    loadImage(displayNext, imgArr[imgNumber + 1].url);
  }
}
