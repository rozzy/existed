# encoding: utf-8

class Existed 
    def initialize title, description, author 
        $title, $description, $author, $articles = title, description, author, []
        $articles << redis.get("mykey")
    end

    def load page = 1

    end
end