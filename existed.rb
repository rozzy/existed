# encoding: utf-8

class Existed 
    def initialize title, description, author 
        $title, $description, $author, $articles = title, description, author, [{title: 'Test', url: '/Test', fav: 0, date: '10 января, 24:14:20', text: 'Текст заметки'}]
    end
end
