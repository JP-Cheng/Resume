#include <fstream>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

using namespace std;

const int VERY_LARGE = 999999;

class Network;

class Path {
private:
    vector<int> nodes;
    int capacity;

public:
    Path();
    Path(int aNode);
    Path(Path aShorterPath, int aNode, int capacity);
    int getTail();
    int getCapacity();
    vector<int> getNodes();
    void printInt();
    void printAugPathString(vector<string> nodeName);
    friend Network;
};

Path::Path()
    : capacity(VERY_LARGE)
{
}

Path::Path(int aNode)
    : capacity(VERY_LARGE)
{
    this->nodes.push_back(aNode);
}

Path::Path(Path aShorterPath, int aNode, int capacity)
{
    for (int i = 0; i < aShorterPath.nodes.size(); i++)
        this->nodes.push_back(aShorterPath.nodes[i]);
    this->nodes.push_back(aNode);
    this->capacity = capacity;
}

void Path::printInt()
{
    if (this->nodes.size() == 0)
        cout << "<empty>" << endl;
    else {
        for (int i = 0; i < this->nodes.size() - 1; i++)
            cout << this->nodes[i] << ",";
        cout << this->nodes.back() << ";";
        cout << this->capacity << endl;
    }
}

void Path::printAugPathString(vector<string> nodeName)
{
    if (this->nodes.size() == 0)
        cout << -1 << endl;
    else {
        for (int i = 0; i < this->nodes.size() - 1; i++)
            cout << nodeName[this->nodes[i]] << ",";
        cout << nodeName[this->nodes.back()] << ";";
        cout << this->capacity << endl;
    }
}

int Path::getTail()
{
    return this->nodes.back();
}

int Path::getCapacity()
{
    return this->capacity;
}

vector<int> Path::getNodes()
{
    return this->nodes;
}

class ForCapacitySort {
public:
    int order;
    int cap;
    ForCapacitySort()
        : order(-1)
        , cap(-1)
    {
    }

    void operator=(ForCapacitySort t)
    {
        this->order = t.order;
        this->cap = t.cap;
    }
};

class Network {
private:
    int n;
    int** resCap;

public:
    Network(int n);
    void adjustArcCap(int node1, int node2, int capacity);
    void print();
    vector<Path> getNextWithResCap(Path aPath);
    Path getAnAugmentingPath();
    void sendOnce(Path anAugPath);
    int maxFlow(vector<string> nodeName);
    int maxFlow(Network& emptyNetwork);
    ~Network();
};

Network::Network(int n)
    : n(n)
{
    this->resCap = new int*[this->n];
    for (int i = 0; i < this->n; i++) {
        this->resCap[i] = new int[this->n];
        for (int j = 0; j < this->n; j++)
            this->resCap[i][j] = 0;
    }
}

void Network::adjustArcCap(int node1, int node2, int capacity)
{
    this->resCap[node1][node2] += capacity;
}

void Network::print()
{
    for (int i = 0; i < this->n; i++) {
        for (int j = 0; j < this->n; j++)
            cout << setw(2) << this->resCap[i][j] << " ";
        cout << endl;
    }
}

// input: a path of length L
// output: a vector of paths of length L + 1
// precondition: aPath is really a path in this network
vector<Path> Network::getNextWithResCap(Path aPath)
{
    vector<Path> longerPaths;
    vector<ForCapacitySort> capPairs;

    // vector<Path> tempPaths;
    int tail = aPath.getTail();

    // get the capacity if positive; sort by capacity
    for (int i = 0; i < this->n; i++) {
        if (this->resCap[tail][i] > 0) {
            ForCapacitySort curCapPair;
            curCapPair.order = i;
            curCapPair.cap = this->resCap[tail][i];
            capPairs.push_back(curCapPair);
            for (int j = capPairs.size() - 1; j > 0; j--) {
                if (capPairs[j].cap > capPairs[j - 1].cap) {
                    ForCapacitySort temp = capPairs[j];
                    capPairs[j] = capPairs[j - 1];
                    capPairs[j - 1] = temp;
                }
            }
        }
    }

    for (int i = 0; i < capPairs.size(); i++) {
        int oldCap = aPath.getCapacity();
        int newCap = oldCap;
        if (capPairs[i].cap < oldCap)
            newCap = capPairs[i].cap;
        Path p(aPath, capPairs[i].order, newCap);
        // usage: Path(shorterPath, aNode, capacity);
        longerPaths.push_back(p);
    }

    return longerPaths;
}

Path Network::getAnAugmentingPath()
{
    // find an augmenting path through BFS
    vector<Path> pathQueue;
    Path start(0);
    const Path empty;
    pathQueue.push_back(start);

    Path anAugmentingPath;
    bool keepGoing = true;
    while (keepGoing && pathQueue.size() > 0) {

        Path cur = pathQueue.front();
        pathQueue.erase(pathQueue.begin());
        vector<Path> curPlusOne = this->getNextWithResCap(cur);

        bool aLoop = false;
        // if a infinite loop
        // then clear curPlusOne
        for (int i = 0; i < cur.nodes.size(); i++) {
            for (int j = 0; j < cur.nodes.size(); j++) {
                if ((cur.nodes[i] == cur.nodes[j]) && (i != j)) {
                    aLoop = true;
                }
            }
        }
        if (aLoop)
            continue;
        else {
            for (int i = 0; i < curPlusOne.size(); i++) {
                // whether the tail is a visited node should be checked below

                //      cout << "..." << curPlusOne[i].getTail() << endl;
                if (curPlusOne[i].getTail() == n - 1) {
                    anAugmentingPath = curPlusOne[i];
                    keepGoing = false; // break while loop
                    return anAugmentingPath;
                    break; // break for loop
                } else
                    pathQueue.push_back(curPlusOne[i]);
            }
        }

        //    cout << "===============\n";
        //    for(int i = 0; i < pathQueue.size(); i++)
        //      pathQueue[i].print();
    }
    return empty;
}

void Network::sendOnce(Path anAugPath)
{
    int flow = anAugPath.getCapacity();
    vector<int> nodes = anAugPath.getNodes();
    // int nodeCnt = nodes.size();
    for (int i = 0; i < nodes.size() - 1; i++) {
        // forward: send something and decrease capacity
        this->adjustArcCap(nodes[i], nodes[i + 1], -flow);
        // backward: add capacity
        this->adjustArcCap(nodes[i + 1], nodes[i], flow);
    }
}

int Network::maxFlow(vector<string> nodeName)
{
    Path anAugPath = this->getAnAugmentingPath();
    // anAugPath.print();
    int maxFlowAmount = 0;

    while (anAugPath.getCapacity() < VERY_LARGE) {
        maxFlowAmount += anAugPath.getCapacity();
        this->sendOnce(anAugPath);
        // this->print();
        // emptyNetwork.print();
        anAugPath.printAugPathString(nodeName);
        anAugPath = this->getAnAugmentingPath();

        // anAugPath.print();
    }

    return maxFlowAmount;
}

int Network::maxFlow(Network& emptyNetwork)
{
    Path anAugPath = this->getAnAugmentingPath();
    // anAugPath.print();
    int maxFlowAmount = 0;

    while (anAugPath.getCapacity() < VERY_LARGE) {
        maxFlowAmount += anAugPath.getCapacity();
        this->sendOnce(anAugPath);
        emptyNetwork.sendOnce(anAugPath);
        // this->print();
        // emptyNetwork.print();

        anAugPath = this->getAnAugmentingPath();
    }

    // clear positive values; flip negative values
    for (int i = 0; i < emptyNetwork.n; i++) {
        for (int j = 0; j < emptyNetwork.n; j++) {
            if (emptyNetwork.resCap[i][j] > 0)
                emptyNetwork.resCap[i][j] = 0;
            else if (emptyNetwork.resCap[i][j] < 0)
                emptyNetwork.resCap[i][j] *= -1;
        }
    }

    return maxFlowAmount;
}

Network::~Network()
{
    for (int i = 0; i < this->n; i++)
        delete[] resCap[i];
    delete[] resCap;
}

int main()
{
    int n = 0, m = 0;
    vector<string> nodeName;
    /*
    string fileName;
    cin >> fileName;
    ifstream inputFile(fileName);
    */
    // ifstream inputFile("sample_p2_2.txt");
    // if (inputFile) {

    string nString = "", mString = "";
    // n, m in the first line
    // getline(inputFile, nString, ',');
    // getline(inputFile, mString, '\n');

    getline(cin, nString, ',');
    getline(cin, mString, '\n');
    n = stoi(nString);
    m = stoi(mString);

    // node names in the second line
    string temp = "";
    for (int i = 0; i < n - 1; i++) {
        // getline(inputFile, temp, ',');
        getline(cin, temp, ',');
        nodeName.push_back(temp);
    }
    // getline(inputFile, temp, '\n');
    getline(cin, temp, '\n');
    nodeName.push_back(temp);

    // below m lines are resCaps
    // and have to change node names (string) to int
    string node1 = "", node2 = "";
    string capString = "";
    int tempCap = 0;
    Network net(n);
    for (int i = 0; i < m; i++) {
        // getline(inputFile, node1, ',');
        // getline(inputFile, node2, ',');
        // getline(inputFile, capString, '\n');
        getline(cin, node1, ',');
        getline(cin, node2, ',');
        getline(cin, capString, '\n');
        tempCap = stoi(capString);

        int u = 0, v = 0;
        // linear search
        for (int i = 0; i < n; i++) {
            if (nodeName[i] == node1)
                u = i;
            if (nodeName[i] == node2)
                v = i;
            if (u * v != 0)
                break;
        }

        net.adjustArcCap(u, v, tempCap);
    }

    // net.print();
    // cout << endl;

    int maxFlowAmount = net.maxFlow(nodeName);
    cout << maxFlowAmount << endl;

    return 0;
}
