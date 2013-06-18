#How to: Specify the image quality
#If you want to set the image quality, create a file config/initializers/carrierwave.rb with the following content:

module CarrierWave
  module RMagick

    def quality(percentage)
      manipulate! do |img|
        img.write(current_path){ self.quality = percentage } unless img.quality == percentage
        img = yield(img) if block_given?
        img
      end
    end

  end
end
#Now you can use the process :quality in your uploaders:

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  
  version :thumb do
    process :resize_to_fit => [100, 100]
    process :quality => 100 
  end
end


#Change quality with MiniMagick
# put this in config/initializers/carrierwave.rb
module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end
end


class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :quality => 85

  version :medium do
    process :quality => 85
  end
end

#注意使用MiniMagick这类图片处理gem需要预先安装ImageMagick，安装命令：yum install ImageMagick  ; apt-get install imagemagick ; brew isntall ImageMagick