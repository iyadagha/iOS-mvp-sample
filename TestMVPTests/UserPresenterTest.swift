import XCTest
@testable import TestMVP

class UserServiceMock: UserService {
    fileprivate let users: [User]
    init(users: [User]) {
        self.users = users
    }
    override func getUsers(_ callBack: @escaping ([User]) -> Void) {
        callBack(users)
    }

}

class UserViewMock : NSObject, UserView{
    var setUsersCalled = false
    var setEmptyUsersCalled = false

    func setUsers(_ users: [UserViewData]) {
        setUsersCalled = true
    }

    func setEmptyUsers() {
        setEmptyUsersCalled = true
    }

    func startLoading() {
    }

    func finishLoading() {
    }

}
class UserPresenterTest: XCTestCase {

    let emptyUsersServiceMock = UserServiceMock(users:[User]())

    let towUsersServiceMock = UserServiceMock(users:[User(firstName: "firstname1", lastName: "lastname1", email: "first@test.com", age: 30),
                                               User(firstName: "firstname2", lastName: "lastname2", email: "second@test.com", age: 24)])
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testShouldSetEmptyIfNoUserAvailable() {
        //given
        let userViewMock = UserViewMock()
        let userPresenterUnderTest = UserPresenter(userService: emptyUsersServiceMock)
        userPresenterUnderTest.attachView(userViewMock)

        //when
        userPresenterUnderTest.getUsers()

        //verify
        XCTAssertTrue(userViewMock.setEmptyUsersCalled)
    }

    func testShouldSetUsers() {
        //given
        let userViewMock = UserViewMock()
        let userPresenterUnderTest = UserPresenter(userService: towUsersServiceMock)
        userPresenterUnderTest.attachView(userViewMock)

        //when
        userPresenterUnderTest.getUsers()

        //verify
        XCTAssertTrue(userViewMock.setUsersCalled)
    }

}
