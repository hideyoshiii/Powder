module ApplicationHelper
	def default_meta_tags
    {
      site: 'A.Date(アデート)',
      title: 'デートコースを10秒で',
      reverse: true,
      charset: 'utf-8',
      description: 'A.Date(アデート)はデートコースを10秒でつくれるサービスです。WebもしくはLINEで質問に答えていくだけでAIにデートコースを提案してもらうことができます。',
      keywords: 'デート, 東京, 提案',
      canonical: 'https://www.a-date.jp',
      separator: '|',
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('apple-touch-icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' }
      ],
      og: {
        site_name: 'A.Date(アデート)',
        title: 'A.Date(アデート)',
        description: 'デートコースを10秒で',
        type: 'website',
        url: 'https://www.a-date.jp',
        image: image_url('title.jpg'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@adate_tw',
        title: 'A.Date(アデート)',
        description: 'デートコースを10秒で',
        type: 'website',
        url: 'https://www.a-date.jp',
        image: image_url('title.jpg')
      }
    }
  end
end
