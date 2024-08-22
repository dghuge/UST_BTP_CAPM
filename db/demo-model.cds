using { ust.resuse as reuse } from './resuse';
using { cuid, managed, temporal } from '@sap/cds/common';


namespace ust.demo;

context master {
    //resuing aspect/structure to automatically add group of fields
    entity student:reuse.address {
        //reusing types by delcaring in different file
        key id: reuse.guid;
        nameFirst: String(50);
        nameLast: String(50);
        age: Integer;
        //foreign key @runtime will create class_id( Strundent + semester key)
        class: Association to semester
    }

    entity semester {
        key id: reuse.guid;
        name : String(30);
        specialization: String(80);
        hod: String(40);
    }

    entity books {
        key code: String(32);
        //to display book name based on language
        bookname: localized String(80);
        author: String(30);
    }
}

context transaction {
    entity subs: cuid,managed,temporal {
        student: Association to master.student;
        book: Association to master.books;
    }
}
