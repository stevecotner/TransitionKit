//
//  SimpsonsCharacter.swift
//  SampleApp
//
//  Created by Stephen Cotner on 11/26/22.
//

import Foundation

struct SimpsonsCharacter: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var imageName: String
    var description: String
}

extension SimpsonsCharacter {
    static func makeCharacters() -> [SimpsonsCharacter] {
        [
            SimpsonsCharacter(
                name: "Bart",
                imageName: "bart",
                description: "Bartholomew JoJo \"Bart\" Simpson (born April 1 or February 23), A.K.A. El Barto and Bartman, is the mischievous, rebellious, misunderstood, and \"potentially dangerous\" eldest child of Homer and Marge Simpson, and the brother of Lisa and Maggie Simpson."
            ),
            
            SimpsonsCharacter(
                name: "Homer Simpson",
                imageName: "homer",
                description: "Homer Jay Simpson, formerly known as Max Power, is the father of the Simpson family. He is overweight, lazy, and ignorant, but also strongly devoted to his wife and children. He works as a low level safety inspector at the Springfield Nuclear Power Plant, in Sector 7G, although he's often incompetent, mostly sleeps on duty and eats the donuts provided. He spends a great deal of his time at Moe's Tavern with his lifelong friends Barney, Carl, Lenny, and bartender Moe Szyslak. At home he can often be found sitting on the sofa mindlessly watching TV while snacking on food and drinking Duff beer."
            ),
            
            SimpsonsCharacter(
                name: "Lisa Simpson",
                imageName: "lisa",
                description: "Lisa Marie Simpson (born May 9) is a charismatic 8-year-old girl, who exceeds the standard achievement level of children her age. Not to everyone's surprise, she's also the moral center of her family. In her upbringing, Lisa lacks parental involvement of Homer and Marge, which leads to hobbies like playing saxophone and guitar, riding and caring for horses, and interest in advanced studies. In school, Lisa's popularity's affected by those who view her as a geeky overachiever, which leaves her with only a few friends. Lisa Simpson's a smart, witty, independent girl who focuses on her goals and strives to reach her potential, and at age 8 she's already a member of MENSA with an IQ of 159."
            ),
            
            SimpsonsCharacter(
                name: "Maggie Simpson",
                imageName: "maggie",
                description: "Margaret Lenny \"Maggie\" Simpson is the youngest child of Marge and Homer, and sister to Bart and Lisa. She is almost always seen sucking on her pacifier and, when she walks, she trips over her clothing and falls on her face. Because she cannot walk or talk, Maggie is the least seen in the Simpson family."
            ),
            
            SimpsonsCharacter(
                name: "Marge Simpson",
                imageName: "marge",
                description: "Marjorie \"Marge\" B. Simpson, (née Bouvier; born March 19), is the happy homemaker and full-time mom of the Simpson family. With her husband Homer, she has three children: Bart, Lisa, and Maggie Simpson. Marge is the moralistic force in her family and often provides a grounding voice in the midst of her family's antics by trying to maintain order in the Simpson household. Aside from her duties at home, Marge flirted briefly with a number of careers ranging from police officer to anti-violence activist."
            ),

            SimpsonsCharacter(
                name: "Milhouse Van Houten",
                imageName: "milhouse",
                description:
                    """
                    Milhouse Mussolini Van Houten (born July 4) is Bart Simpson's best friend. As the only child of Kirk and Luann Van Houten, Milhouse's most distinctive physical traits are his extreme nearsightedness (depicted by very small eyes), requiring thick glasses to correct, and a bulbous potato-shaped nose. Milhouse has his mother's coloring (blue hair) but not her vivacity or confidence, and shares his father's generally milquetoast and defeated demeanor, although Milhouse sometimes gets cocky and overconfident, raising his eyebrows lasciviously, usually while trying to woo Lisa.
                    
                    Despite being considered a nerd, Milhouse is of average intelligence but has poor social skills. He is also very gullible, thus he is often led into trouble by the mischievous Bart, who is not shy about taking advantage. Occasionally, however, Milhouse takes advantage of or manipulates Bart.
                    """
            ),
            
            SimpsonsCharacter(
                name: "Ralph Wiggum",
                imageName: "ralph",
                description:
                    """
                    Ralph Wiggum is a student who attends Springfield Elementary School. He is best known as the town's resident oddball, and has been immortalized for his non sequiturs and erratic behavior. His lines range from purely nonsensical, or bizarre interpretations of a current event, to surprisingly profound statements that go over people's heads. For this, Ralph is somewhat of an outcast among his peers, although he seems to be on good terms with a fair number of the other kids at school such as Bart, Lisa, and Milhouse.

                    The son of Police Chief Clancy and Sarah Wiggum, Ralph is rarely picked on or bullied due to his unscrupulous father's position. He purportedly has immense potential as a musical performer (school roles attained for him, however, by his police chief father's extorting Springfield teachers, including Miss Hoover, which may explain her dislike for Ralph). He also manipulated the Republican and Democratic parties in Springfield to join forces in their support of him for public office in "E Pluribus Wiggum", a parody of voting and elections.
                    """
            ),
        ]
    }
}
