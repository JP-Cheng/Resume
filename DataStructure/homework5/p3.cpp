#include <algorithm>
#include <cassert>
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>

using namespace std;

class PrecondViolatedExcep : public logic_error {
public:
    PrecondViolatedExcep(const string& message)
        : logic_error("Precondition Violated Exception: " + message)
    {
    } // end constructor
}; // end PrecondViolatedExcep

template <class ItemType>
class Node {
private:
    ItemType item;
    Node<ItemType>* next;

public:
    Node();
    Node(const ItemType& anItem);
    Node(const ItemType& anItem, Node<ItemType>* nextNodePtr);
    void setItem(const ItemType& anItem);
    void setNext(Node<ItemType>* nextNodePtr);
    ItemType getItem() const;
    Node<ItemType>* getNext() const;
};

template <class ItemType>
Node<ItemType>::Node()
    : next(nullptr)
{
}

template <class ItemType>
Node<ItemType>::Node(const ItemType& anItem)
    : item(anItem)
    , next(nullptr)
{
}

template <class ItemType>
Node<ItemType>::Node(const ItemType& anItem, Node<ItemType>* nextNodePtr)
    : item(anItem)
    , next(nextNodePtr)
{
}

template <class ItemType>
void Node<ItemType>::setItem(const ItemType& anItem)
{
    item = anItem;
}

template <class ItemType>
void Node<ItemType>::setNext(Node<ItemType>* nextNodePtr)
{
    next = nextNodePtr;
}

template <class ItemType>
ItemType Node<ItemType>::getItem() const
{
    return item;
}

template <class ItemType>
Node<ItemType>* Node<ItemType>::getNext() const
{
    return next;
}

template <class ItemType>
class ListInterface {
public:
    /** Sees whether this list is empty.
    @return True if the list is empty; otherwise returns false. */
    virtual bool isEmpty() const = 0;

    /** Gets the current number of entries in this list.
    @return The integer number of entries currently in the list. */
    virtual int getLength() const = 0;

    /** Inserts an entry into this list at a given position.
    @pre  None.
    @post  If 1 <= position <= getLength() + 1 and the insertion is
       successful, newEntry is at the given position in the list,
       other entries are renumbered accordingly, and the returned
       value is true.
    @param newPosition  The list position at which to insert newEntry.
    @param newEntry  The entry to insert into the list.
    @return  True if insertion is successful, or false if not. */
    virtual void insert(int newPosition, const ItemType& newEntry) = 0;

    /** Removes the entry at a given position from this list.
    @pre  None.
    @post  If 1 <= position <= getLength() and the removal is successful,
       the entry at the given position in the list is removed, other
       items are renumbered accordingly, and the returned value is true.
    @param position  The list position of the entry to remove.
    @return  True if removal is successful, or false if not. */
    virtual bool remove(int position) = 0;

    /** Removes all entries from this list.
    @post  List contains no entries and the count of items is 0. */
    virtual void clear() = 0;

    /** Gets the entry at the given position in this list.
    @pre  1 <= position <= getLength().
    @post  The desired entry has been returned.
    @param position  The list position of the desired entry.
    @return  The entry at the given position. */
    virtual ItemType getEntry(int position) const = 0;

    /** Replaces the entry at the given position in this list.
    @pre  1 <= position <= getLength().
    @post  The entry at the given position is newEntry.
    @param position  The list position of the entry to replace.
    @param newEntry  The replacement entry. */
    virtual void setEntry(int position, const ItemType& newEntry) = 0;
}; // end ListInterface

template <class ItemType>
class LinkedList : public ListInterface<ItemType> {
private:
    Node<ItemType>* headPtr; // Pointer to first node in the chain;
        // (contains the first entry in the list)
    int itemCount; // Current count of list items

    // Locates a specified node in this linked list.
    // @pre  position is the number of the desired node;
    //       position >= 1 and position <= itemCount.
    // @post  The node is found and a pointer to it is returned.
    // @param position  The number of the node to locate.
    // @return  A pointer to the node at the given position.
    Node<ItemType>* getNodeAt(int position) const;

public:
    LinkedList();
    LinkedList(const LinkedList<ItemType>& aList);
    virtual ~LinkedList();

    bool isEmpty() const;
    int getLength() const;

    // insert the newEntry at the end of this list
    void append(const ItemType newEntry) noexcept;

    // insert the newEntry at newPosition if newPosition in valid range
    // else if newPosiiton > itemCount, call this->append(newEntry)
    // else throw an exception
    void insert(int newPosition, const ItemType& newEntry) noexcept(false);
    bool remove(int position);
    // remove the first entry that equals to anEntry, if exists
    // do nothing otherwise
    bool removeElement(const ItemType anEntry) noexcept;
    // return the index the first entry that equals to anEntry, if exists
    // return -1 otherwise
    int getFirstIndex(const ItemType anEntry) const noexcept;
    // return how many times anEntry written in this list
    // return 0 if anEntry not exists
    int countAnElement(const ItemType anEntry) const noexcept;
    // stably append all the member of anotherList to this list
    void extend(const LinkedList<ItemType>& anotherList) noexcept;
    // reverse the index of this list
    // front to end and end to front
    void reverse() noexcept;
    // stably sort this list increasingly
    void sort() noexcept;
    void clear();
    void print() const noexcept;

    /** @throw PrecondViolatedExcep if position < 1 or 
                                      position > getLength(). */
    ItemType getEntry(int position) const noexcept(false);

    /** @throw PrecondViolatedExcep if position < 1 or 
                                      position > getLength(). */
    void setEntry(int position, const ItemType& newEntry) noexcept(false);
}; // end LinkedList

template <class ItemType>
LinkedList<ItemType>::LinkedList()
    : headPtr(nullptr)
    , itemCount(0)
{
} // end default constructor

template <class ItemType>
LinkedList<ItemType>::LinkedList(const LinkedList<ItemType>& aList)
{
    if (aList.isEmpty()) {
        this->headPtr = nullptr;
        this->itemCount = 0;
    } else {
        // copy the first item
        Node<ItemType>* toCopy = aList.getNodeAt(1);
        this->headPtr = new Node<ItemType>();
        this->headPtr->setItem(toCopy->getItem());
        this->headPtr->setNext(nullptr);
        Node<ItemType>* curPtr = this->headPtr;

        // copy the remaining
        while (toCopy->getNext() != nullptr) {
            Node<ItemType>* nextNode = new Node<ItemType>();
            curPtr->setNext(nextNode);

            // shift next
            toCopy = toCopy->getNext();
            curPtr = curPtr->getNext();
            curPtr->setItem(toCopy->getItem());
            curPtr->setNext(nullptr);
        }
    }

} // end copy constructor

template <class ItemType>
LinkedList<ItemType>::~LinkedList()
{
    clear();
} // end destructor

template <class ItemType>
bool LinkedList<ItemType>::isEmpty() const
{
    return itemCount == 0;
} // end isEmpty

template <class ItemType>
int LinkedList<ItemType>::getLength() const
{
    return itemCount;
} // end getLength

template <class ItemType>
void LinkedList<ItemType>::append(const ItemType newEntry) noexcept
{
    Node<ItemType>* newNode = new Node<ItemType>();
    newNode->setItem(newEntry);
    newNode->setNext(nullptr);
    if (!this->isEmpty()) {
        Node<ItemType>* lastNode = this->getNodeAt(itemCount);
        lastNode->setNext(newNode);
    } else {
        this->headPtr = newNode;
    }
    itemCount++;
}

template <class ItemType>
void LinkedList<ItemType>::insert(int newPosition, const ItemType& newEntry) noexcept(false)
{
    bool ableToInsert = (newPosition >= 1) && (newPosition <= itemCount);
    if (ableToInsert) {
        // Create a new node containing the new entry
        Node<ItemType>* newNodePtr = new Node<ItemType>(newEntry);

        // Attach new node to chain
        if (newPosition == 1) {
            // Insert new node at beginning of chain
            newNodePtr->setNext(headPtr);
            headPtr = newNodePtr;
        } else {
            // Find node that will be before new node
            Node<ItemType>* prevPtr = getNodeAt(newPosition - 1);

            // Insert new node after node to which prevPtr points
            newNodePtr->setNext(prevPtr->getNext());
            prevPtr->setNext(newNodePtr);
        } // end if

        itemCount++; // Increase count of entries
    } // end if
    else if (newPosition > itemCount) {
        this->append(newEntry);
    } else {
        string message = "insert() called with non-positive position.";
        throw(PrecondViolatedExcep(message));
    }
} // end insert

template <class ItemType>
bool LinkedList<ItemType>::remove(int position)
{
    bool ableToRemove = (position >= 1) && (position <= itemCount);
    if (ableToRemove) {
        Node<ItemType>* curPtr = nullptr;
        if (position == 1) {
            // Remove the first node in the chain
            curPtr = headPtr; // Save pointer to node
            headPtr = headPtr->getNext();
        } else {
            // Find node that is before the one to delete
            Node<ItemType>* prevPtr = getNodeAt(position - 1);

            // Point to node to delete
            curPtr = prevPtr->getNext();

            // Disconnect indicated node from chain by connecting the
            // prior node with the one after
            prevPtr->setNext(curPtr->getNext());
        } // end if

        // Return node to system
        curPtr->setNext(nullptr);
        delete curPtr;
        curPtr = nullptr;

        itemCount--; // Decrease count of entries
    } // end if

    return ableToRemove;
} // end remove

template <class ItemType>
bool LinkedList<ItemType>::removeElement(const ItemType anEntry) noexcept
{
    Node<ItemType>* curPtr = this->headPtr;
    for (int i = 1; i <= itemCount; i++) {
        if (curPtr->getItem() == anEntry) {
            this->remove(i);
            return true;
        } else
            curPtr = curPtr->getNext();
    }
    return false;
}

template <class ItemType>
int LinkedList<ItemType>::getFirstIndex(const ItemType anEntry) const noexcept
{
    Node<ItemType>* curPtr = this->headPtr;
    for (int i = 1; i <= itemCount; i++) {
        if (curPtr->getItem() == anEntry)
            return i - 1;
        else
            curPtr = curPtr->getNext();
    }
    return -1;
}

template <class ItemType>
int LinkedList<ItemType>::countAnElement(const ItemType anEntry) const noexcept
{
    int count = 0;
    Node<ItemType>* curPtr = this->headPtr;
    for (int i = 1; i <= itemCount; i++) {
        if (curPtr->getItem() == anEntry)
            count++;
        curPtr = curPtr->getNext();
    }
    return count;
}

template <class ItemType>
void LinkedList<ItemType>::extend(const LinkedList<ItemType>& anotherList) noexcept
{
    if (!anotherList.isEmpty()) {
        Node<ItemType>* curPtr = anotherList.headPtr;

        int length = anotherList.itemCount;
        // for if this list extends itself,
        // itemCount will increase dynamically thus endlessly

        for (int i = 1; i <= length; i++) {
            this->append(curPtr->getItem());
            curPtr = curPtr->getNext();
        }
    }
}

template <class ItemType>
void LinkedList<ItemType>::reverse() noexcept
{
    // copy the items to another list then copy them back reversely
    if (!this->isEmpty()) {
        vector<ItemType> temp;
        Node<ItemType>* curPtr = this->headPtr;
        // traverse to push item into temp
        for (int i = 1; i <= itemCount; i++) {
            temp.push_back(curPtr->getItem());
            curPtr = curPtr->getNext();
        }
        // reset to head
        curPtr = this->headPtr;
        // assigning
        for (int i = 1; i <= itemCount; i++) {
            curPtr->setItem(temp[itemCount - i]);
            curPtr = curPtr->getNext();
        }
    }
}

template <class ItemType>
void LinkedList<ItemType>::sort() noexcept
{
    if (!this->isEmpty()) {
        vector<ItemType> temp;
        Node<ItemType>* curPtr = this->headPtr;
        // traverse to push item into temp
        for (int i = 1; i <= itemCount; i++) {
            temp.push_back(curPtr->getItem());
            curPtr = curPtr->getNext();
        }
        // use the global func std::sort in <algorithm>
        // which sort the element in an ascending order
        std::sort(temp.begin(), temp.end());
        // reset to head
        curPtr = this->headPtr;
        // assigning
        for (int i = 1; i <= itemCount; i++) {
            curPtr->setItem(temp[i - 1]);
            curPtr = curPtr->getNext();
        }
    }
}

template <class ItemType>
void LinkedList<ItemType>::clear()
{
    while (!isEmpty())
        remove(1);
} // end clear

template <class ItemType>
void LinkedList<ItemType>::print() const noexcept
{
    if (this->isEmpty())
        cout << "[]" << endl;
    else {
        cout << "[";
        Node<ItemType>* aNode = this->headPtr;
        while (aNode->getNext() != nullptr) {
            cout << aNode->getItem() << ",";
            aNode = aNode->getNext();
        }
        cout << this->getNodeAt(itemCount)->getItem() << "]" << endl;
    }
}

template <class ItemType>
ItemType LinkedList<ItemType>::getEntry(int position) const noexcept(false)
{
    // Enforce precondition
    bool ableToGet = (position >= 1) && (position <= itemCount);
    if (ableToGet) {
        Node<ItemType>* nodePtr = getNodeAt(position);
        return nodePtr->getItem();
    } else {
        string message = "getEntry() called with an empty list or ";
        message = message + "invalid position.";
        throw(PrecondViolatedExcep(message));
    } // end if
} // end getEntry

template <class ItemType>
void LinkedList<ItemType>::setEntry(int position, const ItemType& newEntry) noexcept(false)
{
    bool ableToSet = (position >= 1) && (position <= itemCount);
    if (ableToSet) {
        Node<ItemType>* nodePtr = getNodeAt(position);
        nodePtr->setItem(newEntry);
    } else {
        string message = "setEntry() called with an empty list or ";
        message = message + "invalid position.";
        throw(PrecondViolatedExcep(message));
    } // end if
}

template <class ItemType>
Node<ItemType>* LinkedList<ItemType>::getNodeAt(int position) const
{
    // Debugging check of precondition
    assert((position >= 1) && (position <= itemCount));

    // Count from the beginning of the chain
    Node<ItemType>* curPtr = headPtr;
    for (int skip = 1; skip < position; skip++)
        curPtr = curPtr->getNext();

    return curPtr;
} // end getNodeAt
//  End of implementation

int searchIndex(string aName, vector<string> name) noexcept(false)
{
    for (int i = 0; i < name.size(); i++) {
        if (aName == name[i])
            return i;
    }
    throw(logic_error(" was not found!"));
}

// input: the command string (python list syntax)
// output: a single parameter in between the parantheses
// throw a invalid_argument error if the parameter not found
int getParameter(string command) noexcept(false)
{
    int from = command.find_first_of('(') + 1;
    int len = command.find_first_of(')') - from;
    // set 10000 as very large
    // therein basically not finding a closing parathesis
    if (!((from == command.npos) || (len > 10000)))
        return stoi(command.substr(from, len));
    else
        throw(invalid_argument("parameter not found!"));
}

int main()
{
    string command = "";

    string sysName = "";
    int index = 0;
    vector<string> name;
    LinkedList<int> list[30];

    while (getline(cin, command)) {

        // initialization if not exist
        if (command.find(" = list()") != command.npos) {
            int pos = command.find_first_of('=') - 1;
            name.push_back(command.substr(0, pos));
            // note that contain a space in name
        }

        // search if the list was declared
        else {
            int pos = command.find_first_of(".\n=");
            sysName = command.substr(0, pos);
            try {
                index = searchIndex(sysName, name);
            } catch (logic_error e) {
                cout << "The list \"" << sysName << "\"" << e.what() << endl;
                continue;
            }
        }

        // do sth case by case
        if (command.find(".append") != command.npos) {
            try {
                int aNum = getParameter(command);
                list[index].append(aNum);
            } catch (invalid_argument e) {
                cout << e.what() << endl;
            }
        }

        // note that there is no spaces between ',' and ')'
        else if (command.find(".insert") != command.npos) {
            int from = command.find_first_of('(') + 1;
            int len = command.find_first_of(',') - from;
            int pos = stoi(command.substr(from, len));

            from = command.find_first_of(',') + 1;
            len = command.find_first_of(')') - from;
            int aNum = stoi(command.substr(from, len));

            try {
                list[index].insert(pos + 1, aNum);
            } catch (PrecondViolatedExcep e) {
                cout << e.what() << endl;
            }
        }

        else if (command.find(".remove") != command.npos) {
            try {
                int aNum = getParameter(command);
                list[index].removeElement(aNum);
            } catch (invalid_argument e) {
                cout << e.what() << endl;
            }
        }

        else if (command.find(".index") != command.npos) {
            try {
                int aNum = getParameter(command);
                cout << list[index].getFirstIndex(aNum) << endl;
            } catch (invalid_argument e) {
                cout << e.what() << endl;
            }
        }

        else if (command.find(".count") != command.npos) {
            try {
                int aNum = getParameter(command);
                cout << list[index].countAnElement(aNum) << endl;
            } catch (invalid_argument e) {
                cout << e.what() << endl;
            }
        }

        else if (command.find(".extend") != command.npos) {
            int from = command.find_first_of('(') + 1;
            int len = command.find_first_of(')') - from;
            string anotherName = "";
            int anotherIndex = -1;
            // set 10000 as very large
            // therein basically not finding a closing parathesis
            if (!(from == command.npos) && (len < 10000)) {
                anotherName = command.substr(from, len);
            }

            // extend
            try {
                anotherIndex = searchIndex(anotherName, name);
                list[index].extend(list[anotherIndex]);
            }

            // incase list with anotherName not found
            catch (logic_error e) {
                cout << "The list \"" << anotherName << "\"" << e.what() << endl;
                continue;
            }
        }

        else if (command.find(".reverse") != command.npos) {
            list[index].reverse();
        }

        else if (command.find(".sort") != command.npos) {
            list[index].sort();
        }

        else if (command.find_first_of("()") == command.npos)
            list[index].print();
    }

    return 0;
}