class SampleMailer < ApplicationMailer

  def send_when_accept(email,area,time_start,time_end,price_min,price_max,image,relation,age_you,sex_you,age_opponent,sex_opponent,spot,term)
    @email = email
    @area = area
    @time_start = time_start
    @time_end = time_end
    @price_min = price_min
    @price_max = price_max
    @image = image
    @relation = relation
    @age_you = age_you
    @sex_you = sex_you
    @age_opponent = age_opponent
    @sex_opponent = sex_opponent
    @spot = spot
    @term = term
    mail to:      @email,
         subject: 'デートコースのご提案'
  end

  def send_when_update(email,area,time_start,time_end,price_min,price_max,image,relation,age_you,sex_you,age_opponent,sex_opponent,spot,term)
    @email = email
    @area = area
    @time_start = time_start
    @time_end = time_end
    @price_min = price_min
    @price_max = price_max
    @image = image
    @relation = relation
    @age_you = age_you
    @sex_you = sex_you
    @age_opponent = age_opponent
    @sex_opponent = sex_opponent
    @spot = spot
    @term = term
    mail to:      @email,
         subject: 'デートコースのご提案'
  end

  def send_when_off(email,area,time_start,time_end,price_min,price_max,image,relation,age_you,sex_you,age_opponent,sex_opponent,spot,term)
    @email = email
    @area = area
    @time_start = time_start
    @time_end = time_end
    @price_min = price_min
    @price_max = price_max
    @image = image
    @relation = relation
    @age_you = age_you
    @sex_you = sex_you
    @age_opponent = age_opponent
    @sex_opponent = sex_opponent
    @spot = spot
    @term = term
    mail to:      @email,
         subject: 'デートコースのご提案'
  end
end
