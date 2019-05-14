#include <exception>
using namespace std;

template <typename Itemtype>
Itemtype LinkedList<Itemtype>::getEntry(int position) noexcept(false)
{
    Itemtype node;
    LinkedList<Itemtype>* aList = new LinkedList;
    int cnt = this->getLength();
    if (position >= 1 && position <= cnt) {
        // shallow copy until getting the entry at position
        // since always insert at the beginning of aList
        // it is a stable insertion
        for (int i = cnt; i >= position; i--) {
            aList->insert(1, this->getLastEntry());
            this->remove(i);
        }

        // since stable insertion,
        // the entry of position is at the beginning
        // keep insert at position, it is also a stable insertion
        for (int i = position; i < cnt - 1; i++) {
            this->insert(position, aList->getLastEntry());
            aList.remove(aList->getLastEntry());
        }
        node = aList->getLastEntry();

        this->insert(position, aList->getLastEntry());
        aList.remove(aList->getLastEntry());
        delete aList;
        return nodePtr;
    } else
        throw(logic_error("invalid position!"));
}