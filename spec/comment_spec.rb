describe Comment do
  describe '.add' do
    it 'it can add comments' do
      connect_to_test_database_and_enter_3_films
      comment = Comment.add(title: "Film 2 Title", comment:
        "This is a comment about the film that user can make")

      expect(Comment.all).to eq(comment)
    end
  end

  describe '.all' do
    it 'returns all comments' do
      add_film_and_rating_to_test_database("Film 1", "10")
      add_film_and_rating_to_test_database("Film 2", "10")
      add_film_and_rating_to_test_database("Film 3", "10")

      cmt_1 = Comment.add(title: "Film 1", comment: "Comment 1")
      cmt_2 = Comment.add(title: "Film 1", comment: "Comment 2")
      cmt_3 = Comment.add(title: "Film 2", comment: "Comment 3")
      cmt_4 = Comment.add(title: "Film 3", comment: "Comment 4")

      expected_comments = [
        cmt_1.first,
        cmt_2.first,
        cmt_3.first,
        cmt_4.first
      ]

      expect(Comment.all).to eq expected_comments
    end
  end

  describe '#==' do
    it 'two comments are equal if their ids match' do
      add_film_and_rating_to_test_database("Film Title", "10")
      comment_1 = Comment.add(title: "Film Title", comment: "Random comment")
      comment_2 = Comment.all

      expect(comment_1).to eq(comment_2)
    end
  end

  def connect_to_test_database_and_enter_3_films
    connection = PG.connect(dbname: 'faldo_movie_ratings_test')
    connection.exec("INSERT INTO films (title, rating) VALUES ('Film 1 Title', '10');")
    connection.exec("INSERT INTO films (title, rating) VALUES ('Film 2 Title', '7');")
    connection.exec("INSERT INTO films (title, rating) VALUES ('Film 3 Title', '8');")
  end

  def add_film_and_rating_to_test_database(title, rating)
    connection = PG.connect(dbname: 'faldo_movie_ratings_test')
    connection.exec("INSERT INTO films (title, rating) VALUES ('#{title}', '#{rating}');")
  end
end

# I built this before I created .all, I don't think I need it
# but leaving here in case it proves useful in future
# describe '.show' do
#   it 'shows the comments for given film' do
#     connect_to_test_database_and_enter_3_films
#     comment = Comment.add(title: "Film 2 Title", comment: "This is a comment about the film that users can make")
#
#     expect(Comment.show(title: "Film 2 Title")).to eq(comment)
#   end
# end
