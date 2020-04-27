require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do 
    ＠comment = FactoryBot.build(:comment) 
  end
  let(:comment) do
    FactoryBot.build(:comment)
  end

  describe "バリデーションテスト" do
    context "コメントが空の時" do
      it "バリデーションエラーが発生すること" do
        comment.comment = "  "
        comment.valid?
        expect(comment.errors[:comment]).to include("を入力してください")
      end
    end
    context "コメントが256文字以上の時" do
      it "バリデーションエラーが発生すること" do
        comment.comment = "a"*257
        comment.valid?
        expect(comment.errors[:comment]).to include("は256文字以内で入力してください")
        comment.comment = "a"*256
        comment.valid?
        expect(comment).to be_valid
      end
    end
  end
end 