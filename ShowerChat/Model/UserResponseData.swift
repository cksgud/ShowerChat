//
//  ResponseMaker.swift
//  ShowerChat
//
//  Created by ๊น์ฐฌํ on 2021/09/05.
//

import SwiftUI

struct UserResponseData: Hashable {
    let responses: [String]
}
#if Melissa
extension UserResponseData {
    static func all() -> [UserResponseData] {
        return [
//            UserResponseData(responses: ["๐๐ป\n\n์ข์์", "๐๐ป๐ค๐ป\n\n๋ณดํต์ด์์", "๐๐ป\n\n์ฐ์ธํด์"]),
            
            UserResponseData(responses: ["์ข์์", "๋ณดํต์ด์์", "์ฐ์ธํด์"]),
            UserResponseData(responses: ["๋ง์์", "๊ด์ฐฎ์์"]),
            UserResponseData(responses: ["โถ Better Together  Pate Jonas", "๋ค์์ ๋ค์๊ฒ์"]),
            UserResponseData(responses: ["์กฐ๊ธ์ ๋์์ง ๊ฒ ๊ฐ์์", "๊ทธ์  ๊ทธ๋์"]),
            UserResponseData(responses: ["์กฐ๊ธ์ ๋์์ง ๊ฒ ๊ฐ์์", "๊ทธ์  ๊ทธ๋์"]),
            UserResponseData(responses: ["๊ทธ๊ฒ ๋ฌด์จ ์๋ฏธ์์?"]),
            UserResponseData(responses: ["๊ทธ๋ ๊ตฐ์"]),
            UserResponseData(responses: ["์นํ ์น๊ตฌ์ ์๋ค๋จ๊ธฐ", "๊ฐ์กฑ๊ณผ ์๊ฐ ๋ณด๋ด๊ธฐ"]),
            UserResponseData(responses: ["ํ์ค ์ผ๊ธฐ ์ฐ๋ฌ ๊ฐ๊ธฐ", "๋ํ ์ด์ด๊ฐ๊ธฐ"]),
            UserResponseData(responses: ["๊ณต๊ฐํด์"]),
            UserResponseData(responses: ["๊ณต๊ฐํด์"]),
            UserResponseData(responses: ["๋ค์"]),
            UserResponseData(responses: ["๊ผญ ๊ธฐ์ตํ ๊ฒ์"]),
            UserResponseData(responses: ["๋ง์ด ์ข์์ก์ด์. ๊ณ ๋ง์์.", "๋ํ ์ข๋ฃํ๊ธฐ"]),
            UserResponseData(responses: ["๋ช์ํ๋ฌ ๊ฐ๊ธฐ", "๋ํ ์ข๋ฃํ๊ธฐ"]),
            UserResponseData(responses: ["๋ช์ ๋๋ด๊ธฐ"]),
            UserResponseData(responses: [""])
        ]
    }
}
#else
extension UserResponseData {
    static func all() -> [UserResponseData] {
        return [
            UserResponseData(responses: ["์ข์", "๋ณดํต์ด์ผ", "์ฐ์ธํด"]),
            UserResponseData(responses: ["๋ง์", "๊ด์ฐฎ์"]),
            UserResponseData(responses: ["โถ Better Together  Pate Jonas", "๋ค์์ ๋ค์๊ฒ"]),
            UserResponseData(responses: ["์กฐ๊ธ์ ๋์์ง ๊ฒ ๊ฐ์", "๊ทธ์  ๊ทธ๋"]),
            UserResponseData(responses: ["์กฐ๊ธ์ ๋์์ง ๊ฒ ๊ฐ์", "๊ทธ์  ๊ทธ๋"]),
            UserResponseData(responses: ["๊ทธ๊ฒ ๋ฌด์จ ์๋ฏธ์ผ?"]),
            UserResponseData(responses: ["๊ทธ๋ ๊ตฌ๋"]),
            UserResponseData(responses: ["์นํ ์น๊ตฌ์ ์๋ค๋จ๊ธฐ", "๊ฐ์กฑ๊ณผ ์๊ฐ ๋ณด๋ด๊ธฐ"]),
            UserResponseData(responses: ["ํ์ค ์ผ๊ธฐ ์ฐ๋ฌ ๊ฐ๊ธฐ", "๋ํ ์ด์ด๊ฐ๊ธฐ"]),
            UserResponseData(responses: ["๊ณต๊ฐํด"]),
            UserResponseData(responses: ["๊ณต๊ฐํด"]),
            UserResponseData(responses: ["๋ค์"]),
            UserResponseData(responses: ["๊ผญ ๊ธฐ์ตํ ๊ฒ"]),
            UserResponseData(responses: ["๋ง์ด ์ข์์ก์ด. ๊ณ ๋ง์.", "๋ํ ์ข๋ฃํ๊ธฐ"]),
            UserResponseData(responses: ["๋ช์ํ๋ฌ ๊ฐ๊ธฐ", "๋ํ ์ข๋ฃํ๊ธฐ"]),
            UserResponseData(responses: ["๋ช์ ๋๋ด๊ธฐ"]),
            UserResponseData(responses: [""])
        ]
    }
}
#endif
