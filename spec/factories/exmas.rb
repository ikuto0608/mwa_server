questions = [
                "In any case, the union has to compromise to a certain extent.",
                "Competent mechanics are in great demand, so they earn decent wages.",
                "The president announced a concrete plan to carry out welfare reform.",
                "His policy will no doubt lead to dismal consequences. It needs a through review.",
                "It goes without saying that the aging of society is inevitable.",
                "Please take a look at this chart. It indicates that juvenile delinquency is on the increase at an alarming rate.",
                "In many business districts, there are a lot of vacant lots which have been for sale for years.",
                "In all likelihood, the birthrate will continue to decline steadily for years to come.",
                "The power plant supplies the remote county with electricity.",
                "You are not allowed to operate this device without permission."
              ]

questions_array = questions.map {|q| q.split }

descriptions = [
                  "いずれにせよ、組合側はある程度妥協しなければならない。",
                  "有能な整備士は引っ張りだこだから、なかなかの賃金を稼げる。",
                  "大統領は福祉改革を実行するための具体的な計画を発表した。",
                  "彼の政策はきっと暗い結果を招くだろう。徹底的な見直しが必要だ。",
                  "社会の高齢化が避けられないことは言うまでもない。",
                  "この表をご覧になってください。少年非行が深刻な割合で増加していることを示しています。",
                  "多くの商業地区では、数年間売りに出されている空き地がたくさんある。",
                  "ほぼ間違いなくこの先数年、出生率は減少の一途をたどるだろう。",
                  "その発電所は遠く離れた郡に電気を供給している。",
                  "許可なくこの装置を操作することはできません。"
                ]

FactoryGirl.define do
  sequence :topic do |n|
    Topic.create(
              question: questions[n],
              question_array: questions_array[n],
              index_array_of_answer: [1, 2],
              user_id: 1,
              exam_id: Exam.first.id,
              description: descriptions[n],
              )
  end

  factory :exam do
    name { Faker::Name.name }
    user_id { 1 }
    number_of_answer { 2 }
    description { "Description" }

    factory :exam_with_topics do
      after(:create) do |exam|
        10.times { generate :topic }
      end
    end
  end
end

FactoryGirl.define do

end
