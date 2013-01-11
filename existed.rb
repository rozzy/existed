# encoding: utf-8

class Existed 
    def initialize
        $ready = redis.get 'ready'
        if $ready
            $title = redis.get 'title'
            $description = redis.get 'description'
            $author = redis.get 'author'
            $articles = []
            $articles << redis.get("mykey")
        end
    end

    def load page = 1

    end
end