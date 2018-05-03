module ApplicationHelper
	def default_meta_tags
    {
      title: 'A.Date',
      reverse: true,
      charset: 'utf-8',
      description: '誰でもデートコースを10秒で',
      keywords: 'デート, 東京, 提案',
      canonical: 'https://www.a-date.jp',
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('apple-touch-icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' }
      ],
      og: {
        site_name: 'A.Date',
        title: 'A.Date',
        description: '誰でもデートコースを10秒で',
        type: 'website',
        url: 'https://www.a-date.jp',
        image: image_url('title.jpg'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@adate_tw',
        title: 'A.Date',
        description: '誰でもデートコースを10秒で',
        type: 'website',
        url: 'https://www.a-date.jp',
        image: image_url('title.jpg')
      }
    }
  end
end
