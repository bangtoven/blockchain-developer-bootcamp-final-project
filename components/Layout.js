// components/Layout.js
import Head from 'next/head';

import Header from './Header';

import css from './Layout.module.css';

const Layout = (props) => {
  return (
    <div>
      <Head>
        <title>Crypto Composer</title>
        <link rel="icon" href="/favicon.ico" />
        <meta name="viewport" content="width=900, initial-scale=1, shrink-to-fit=no" />
        <meta name="theme-color" content="#000000" />
        <style>@import url('https://fonts.googleapis.com/css2?family=Noto+Sans&display=swap');</style>
      </Head>
      <body>
        <Header />
        <div className={css.main}>{props.children}</div>
      </body>
    </div>
  );
};

export default Layout;
